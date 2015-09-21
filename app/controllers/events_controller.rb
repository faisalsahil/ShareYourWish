class EventsController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource :except => [:invite, :visitor_entrance, :show, :reward_certificate]
  before_filter :authenticate_user!, :except => [:invite, :show, :visitor_entrance, :reward_certificate]
  before_filter :setup_event_form, :only => [:new, :edit]
  force_ssl :only => :show, :if => :production?
  before_filter :force_http, :except => :show

  def index
    if current_user
      @events = current_user.events.complete_or_open
    else
      redirect_to :new_user_registration, notice: 'Please Sign In First'
    end
  end

  # GET /events/user/:user_id/new/
  def new
    # handling to tell user if we found an existing event, but don't keep displaying the same notice... save it in a cookie
    if Event.users_in_progress_event(current_user)
      @event = Event.users_in_progress_event(current_user)
      if session[:existing_event_notice]==@event.id
        @existing_event_notice = false
      else
        @existing_event_notice = true
        session[:existing_event_notice] = @event.id
      end
    else
      @event = Event.create!({:user => current_user, :package => Package.free, :step => @steps.first, :state => 'open'})
    end
    @cart = current_cart # don't do this in before_filter, need to have event_id or might not find existing old cart
    @cart.update_attribute(:event_id, @event.id)
    setup_order
    @new = true
    @selected_charities = @event.charities
  end

  # GET /events/1
  # GET /events/1.json
  # GET /events/:slug/guest/:guest_id/:guest_access_token
  def show
    @event = params[:slug] ? Event.find_by_slug(params[:slug]) : Event.find(params[:id])
    not_found if @event.nil?

    if params[:guest_id]
      @guest = Guest.find(params[:guest_id]) || not_found
    else
      @guest = Guest.find(Guest::ANONYMOUS_ID) || not_found
      unless @event.publicly_viewable? || (current_user && (@event.owner?(current_user) || current_user.is_admin?))
        return redirect_to visitor_entrance_event_path(@event)
      end
    end
    @comments = @event.comments.paginate(:page => params[:page])
    unless @event.contributions_locked? || @guest.contributed?
      @contribution = params[:contribution] ? Contribution.new(params[:contribution]) : @guest.build_contribution(:event => @event, :amount => '0.00')
      @payment = @contribution.build_payment
      @show_open = params[:contribution].present? || @guest.anonymous?
      @lookup_guests_status_rejected = LookupGuestsStatus.find_by_status_code(:hasRejectedDonation)
      @lookup_guests_status_made_donation = LookupGuestsStatus.find_by_status_code(:hasMadeDonation)
    end
    if params[:guest_access_token]
      guest_access_token = params[:guest_access_token]
      if @guest.guest_access_token != guest_access_token
        redirect_to :root, notice: 'Error: Tried to Access an Event but Guest Code is Invalid'
      end
    end
    @layout = params[:layout] ? false : true
    respond_to do |format|
      format.html { render :show, :layout => @layout } # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/dashboard
  # GET /events/1/dashboard.json
  def dashboard
    @event = Event.find(params[:id]) || not_found
    @event_activity_logs = @event.event_activity_logs.paginate(:page => params[:page]).order('created_at desc')
    @lookup_event_sequences = LookupEventSequence.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/:id/edit(.:format)
  # GET /events/:id/edit.json
  def edit
    @event = Event.find(params[:id]) || not_found
    @edit = true;
    @cart = current_cart # don't do this in before_filter, need to have event_id or might not find existing old cart
    @cart.update_attribute(:event_id, @event.id)
    setup_order
    @selected_charities = @event.charities
  end

  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.json { render json: @event, status: :created }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT	/events/:id.json
  def update
    @steps = Step.all || not_found
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        @event.publish! if params[:event][:status] == 'published'
        format.json { render json: @event, status: :ok }
        format.html { redirect_to :back, notice: 'Event was successfully updated' }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.html { redirect_to :back, notice: 'Error: Event update failed' }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id]) || not_found
    case @event.status
      when 'in_progress'
        @event.destroy
      else
        @event.update_attribute(:state, :cancelled)
    end

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def invitation_insert
    @event = Event.find(params[:id]) || not_found
    render :layout => false
  end

  def visitor_entrance
    @event = Event.find(params[:id]) || not_found
    @guest = @event.guests.build(params[:guest])
    if request.post? && params[:magic_phrase] && @guest.email.present?
      if @event.magic_phrase_valid?(params[:magic_phrase])
        @guest = Guest.find_or_create_by_email_and_event_id(@guest.email, @guest.event_id, :full_name => @guest.full_name)
        EventActivityLog::new_magic_phrase_guest @guest
        redirect_to event_guest_invite_path(@event.slug, @guest, @guest.guest_access_token), notice: 'Your magic phrase is correct. Welcome.'
      else
        @guest.errors.add(:magic_phrase, 'Your magic phrase isn\'t correct. Please check it one more time.')
      end
    end
  end

  def clear_cart
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.order.empty!
        format.json { render json: @event, status: :ok }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def steps_states
    @event = Event.find(params[:id])
    render :json => {:states => @event.steps_states}, :status => :ok
  end

  def invite
    @event = Event.find_by_slug(params[:slug]) || not_found
    authorize! :invite, Event
    guest = Guest.find(params[:guest_id]) || not_found
    guest_access_token = params[:guest_access_token]
    if guest.guest_access_token == guest_access_token
      guest.update_attribute(:lookup_guests_status_id, 3)
      redirect_to event_guest_show_path
    else
      redirect_to :root, notice: 'Sorry, there was an error accessing this event using the guest token'
    end
  end

  def release_gift_fund
    # this function will launch separate page/action to disperse funds from the Gift Fund to an Amazon Gift Card
    @event = Event.find(params[:id])
    EventTransactionLog.gift_fund_disbursement @event
    redirect_to @event, :status => :unauthorized unless @event.owner? current_user
    redirect_to :back, notice: 'This function is not yet implemented'
  end

  def release_donation_fund
    # this function will launch separate page/action to disperse funds from the Gift Fund to an Amazon Gift Card
    @event = Event.find(params[:id])
    EventTransactionLog.donation_fund_disbursement @event
    redirect_to @event, :status => :unauthorized unless @event.owner? current_user
    redirect_to :back, notice: 'This function is not yet implemented'
  end

  def charities
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { render :charities, :layout => false }
      format.json { render :json => {:charities => @event.charities}, :status => :ok }
    end
  end

  def guests
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { render :guests, :layout => false }
      format.json { render :json => {:guests => @event.guests}, :status => :ok }
    end
  end

  def reward_certificate
    @event = Event.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = EventRewardsCertificate.new(:template => EventRewardsCertificate::TEMPLATE_PATH).to_pdf(@event)
        send_data pdf, :filename => "reward_certificate.pdf", :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end

  private
  def setup_event_form
    @steps = Step.all || not_found
    @packages = Package.all
    @items = Item.no_package_proxies
    @statuses = LookupGuestsStatus.all
    @lookup_event_sequences = LookupEventSequence.all
    @themes = Theme.all
    @states = State.all
    @charities = Charity.featured
    @mailing_address = current_user.mailing_address.present? ? current_user.mailing_address : current_user.build_mailing_address
  end

  def setup_order
    order_params = {:shipping_total_cost => 1.50}
    order_params.merge(params[:order]) if params[:order]
    @order = Order.find_or_initialize_by_event_id(params[:id], order_params)
    @order.transmit_line_items_from_cart(@cart) if @cart
    @payment = @order.payment.present? ? @order.payment : @order.build_payment
    @shipping_address = @order.shipping_address.present? ? @order.shipping_address : @order.build_shipping_address
  end

end
