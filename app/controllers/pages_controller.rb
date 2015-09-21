class PagesController < ApplicationController
  authorize_resource :class => false, :only => :show
  before_filter :force_http
  
  def show
    if params[:page]=='landing'   # temp, special handling
       render 'pages/landing_B'
    elsif params[:page]=='presskit'  # is there a better way to do this
       redirect_to '/ShareYourWish_EPK.pdf'
    elsif template_exists?(params[:page], ['pages'])
      render 'pages/' + params[:page]
    else
      @page = Page.find_by_slug(params[:page]) || not_found
    end
  end

  def index
    if user_signed_in?
      render 'pages/home'
    else
      render 'pages/landing_B'
    end
  end
end
