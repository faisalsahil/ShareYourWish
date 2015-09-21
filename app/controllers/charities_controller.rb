class CharitiesController < ApplicationController
  #before_filter :authenticate_user!
  #caches_action :show

  def index
    @public = params[:public]
    @charities = if(params[:featured])
      Charity.featured
    elsif(params[:top_recommended])
      Charity.top_recommended
    elsif(params[:name] || params[:lookup_charity_code_id] || params[:region])
      Charity.search(params, [[:name, :description], :lookup_charity_code_id, :region])
    else
      Charity.all
    end

    if request.xhr?
      render :index, :layout => false
    end
  end

  def show
    @charity = Charity.find_by_id params[:id] || not_found
    @full = params[:full]
    @public = params[:public]
    @selected_charities = params[:selected_charities] ? Charity.find(params[:selected_charities]) : []
    if @full
      @all_charities = case params[:list]
      when 'featured'
        Charity.featured
      when 'top_recommended'
        Charity.top_recommended
      else
        Charity.ordered_by_name
      end
      @charity = @all_charities[params[:page].to_i-1] if params[:page]
      @charities = @all_charities.paginate(:page => get_page_for(@charity, @all_charities)+1, :per_page => 1)
    end
    if request.xhr?
      render @charity, :locals => { :picked => params[:picked] ? true : false }
    end
  
  end

  def event_charities
    @event = Event.find_by_id params[:event_id] || not_found
    @selected_charities = params[:selected_charities] ? Charity.find(params[:selected_charities]) : []
    @charities = if(params[:featured])
      Charity.featured
    elsif(params[:top_recommended])
      Charity.top_recommended
    elsif(params[:name] || params[:lookup_charity_code_id] || params[:region])
      Charity.search(params, [[:name, :description], :lookup_charity_code_id, :region])
    else
      Charity.ordered_by_name
    end

    if request.xhr?
      render :index, :layout => false
      #format.json { render json: @charities }
    end
  end
  
  def browse
    @charities = Charity.featured
    @public = true
  end
  
  private
  def get_page_for charity, charities
    return 1 unless charity && charities
    index = charities.pluck(:id).index(charity.id)
    index.nil? ? 1 : index
  end
  
end
