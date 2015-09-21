class GuestMailerController < ApplicationController
  layout false
  def invite
    @guest = Guest.find(params[:id]) || not_found
  end

  def remind
    @guest = Guest.find(params[:id]) || not_found
  end

  def remind_fortyeight
    @guest = Guest.find(params[:id]) || not_found
  end
  
  def thank
    @guest = Guest.find(params[:id]) || not_found
  end
  
  def custom
    @guest = Guest.find(params[:id]) || not_found
    @subject = ""
    @title = ""
    @body = ""
  end
end
