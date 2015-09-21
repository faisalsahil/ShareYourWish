class AuthenticationsController < ApplicationController #Devise::OmniauthCallbacksController
  
  def index
    redirect_to root_path
  end
  
  def create
     reset_session
     omniauth = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication  # We got a uid matching a past authentication, pull the User_ID from it and log them in
       flash[:notice] = "Successful login"
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user # there was not a matching authentication, but there is already a User record so just add this new auth method to account
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Successful login"
       redirect_to edit_user_registration_path
     else
       # either this is a first time user, or there is an existing user who previously signed up using email (and no authentication records)
       @user = User.find_or_initialize_by_email(omniauth['info']['email'])  # User.new
       @user.apply_omniauth(omniauth)
       if @user.save
         flash[:notice] = "Successful login"
         sign_in_and_redirect(:user, @user)
       else 
         flash[:notice] = "Thanks! To complete your registration, please review the items below."
         @user.errors.clear
         render 'devise/registrations/new'
       end
     end
  end
  
  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    respond_to do |format|
      format.html { redirect_to authentications_url, :notice => "Successfully destroyed authentication." }
      format.json { render json: {:result => true}, :status => :ok }
    end 
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
  
end
