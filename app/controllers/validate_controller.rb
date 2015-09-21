class ValidateController < ApplicationController
  before_filter :authenticate_user!
  def event_valid?
    event = Event.find_by_id(params[:id])
    event.send("#{params[:property]}=".to_sym, params[:value])
    render :json => {:result => event.valid?, :errors => event.errors}
  end

end
