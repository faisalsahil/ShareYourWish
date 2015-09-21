class GuestsController < ApplicationController
  layout false

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id]) || not_found
    @event = @guest.event
    @dashboard = params[:dashboard] 
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  def edit
    @guest = Guest.find(params[:id]) || not_found
    @event = @guest.event
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])

    if @guest.save
      render json: {:guest => @guest}, status: :ok
    else
      render json: @guest.errors, status: :unprocessable_entity
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find_by_id(params[:id])
    
    if @guest.update_attributes(params[:guest])
      render json: {:result => true, :guest => @guest}, status: :ok
    else
      render json: {:result => false, :errors => @guest.errors}, status: :ok
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = params[:id] ? Guest.find(params[:id]) : Guest.find_by_event_id_and_email(params[:guest][:event_id], params[:guest][:email])

    respond_to do |format|
      if @guest.destroy
        format.html { redirect_to guests_path }
        format.json { head :no_content }
      else
        format.html { redirect_to guests_path }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite
    @guest = Guest.find(params[:id]) || not_found
    respond_to do |format|
      if @guest.invite!
        format.html { redirect_to @guest, notice: 'Guest was successfully invited.' }
        format.json { render json: @guest, status: :ok }
      else
        format.html { redirect_to :back, notice: 'Failure inviting guest' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def remind
    @guest = Guest.find(params[:id]) || not_found
    respond_to do |format|
      if @guest.remind!
        format.html { redirect_to @guest, notice: 'Guest was successfully reminded.' }
        format.json { render json: @guest, status: :ok }
      else
        format.html { redirect_to :back, notice: 'Failure reminding guest' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def thank
    @guest = Guest.find(params[:id]) || not_found
    respond_to do |format|
      if @guest.thank!
        format.html { redirect_to @guest, notice: 'Guest was successfully thanked.' }
        format.json { render json: @guest, status: :ok }
      else
        format.html { redirect_to :back, notice: 'Failure thank guest' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def custom
    @guest = Guest.find(params[:id]) || not_found
    respond_to do |format|
      if @guest.send_custom_message!(params[:subject], params[:title], params[:body])
        format.html { redirect_to @guest, notice: 'Message was successfully sent.' }
        format.json { render json: @guest, status: :ok }
      else
        format.html { redirect_to :back, notice: 'Failure send custom message' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def confirm_reminder
    @guest = Guest.find(params[:id]) || not_found
    respond_to do |format|
      if @guest.confirm_reminder!
        format.html { redirect_to @guest, notice: 'Guest was successfully confirmed.' }
        format.json { render json: @guest, status: :ok }
      else
        format.html { redirect_to :back, notice: 'Failure confirming guest' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  # GET /guests/1/uninvited
  # GET /guests/1/uninvited.json
  def uninvited
    @guest = Guest.find(params[:id]) || not_found
    @event = @guest.event
    respond_to do |format|
      format.html # uninvited.html.erb
      format.json { render json: @guest }
    end
  end
  
end
