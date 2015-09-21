class RegistrationsController < Devise::RegistrationsController  ## <-- look, inherits Devise
 
  def new 
    @user = User.new
  end
 
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
    session[:return_path] = "new user"
  end
  
  private
  
  def build_resource(*args)
    super
      # This attempt to re-apply omniauth data from session storage is problematic (see note on Authentications controller)
      #
      # if session[:omniauth]
      #   @user.apply_omniauth(session[:omniauth])
      #   @user.valid?
      # end
      #
      # do this instead to clear up stuck users
      session[:omniauth] = nil
  end
end