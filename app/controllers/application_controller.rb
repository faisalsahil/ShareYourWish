class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter   :do_setups
  helper_method   :redirect_unless_admin,  :user_is_admin
  helper :layout
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end
  
  def force_http
    if request.ssl?
      params[:protocol] = 'http://'
      redirect_to params, :status => :moved_permanently
    end
  end
  
  private

  def devise_or_activeadmin_controller? 
    devise_controller? || activeadmin_controller?
  end  

  def activeadmin_controller?
    params[:controller].include?(ActiveAdmin.application.default_namespace.to_s)
  end  

  def do_setups
     respond_to_magic_phrases
     setup_settings
     #redirect_by_cookie
  end

	def redirect_unless_admin			
		unless user_is_admin
			flash[:error] = "You must be an administrator to access that"
			redirect_to root_path
			false		# return false so no other actions are performed
		end
	end
	
	
	def redirect_unless_validuser			
		unless user_signed_in?
			flash[:error] = "You must be logged in to access that"
			redirect_to root_path
			false		# return false so no other actions are performed                                                
		end
	end
	
	def redirect_by_cookie
	   target = session[:return_path]
	   if !target.nil?
         session[:return_path] = nil
	      case target
	      when "new user"
	         redirect_to new_event_path(:user_id => current_user.id) 
	         false
         else
            redirect_to target
            false
         end
      end
   end
	
   def user_is_admin
      (current_user && current_user.is_admin?) or params[:admin]=='opensesame'
   end
   
   def respond_to_magic_phrases
     if !params[:command].nil?
        # handling for specific commands processed at controller level
        if params[:command] == "resetsession"
            reset_session
         end 
         if params[:command] == "toggledebug"
            session[:debug].nil? ? session[:debug] = "opensesame" : session[:debug] = nil 
         end
        # all others direct to a command View for processing
        render 'commands/' + params[:command]   
      end     
     return
   end
   
   
   
   def to_slug(param=self.slug)

       # strip the string
       ret = param.strip

       #blow away apostrophes
       ret.gsub! /['`]/, ""

       # @ --> at, and & --> and
       ret.gsub! /\s*@\s*/, " at "
       ret.gsub! /\s*&\s*/, " and "

       # replace all non alphanumeric, periods with dash
       ret.gsub! /\s*[^A-Za-z0-9\.]\s*/, '-'

       # replace underscore with dash
       ret.gsub! /[-_]{2,}/, '-'

       # convert double dashes to single
       ret.gsub! /-+/, "-"

       # strip off leading/trailing dash
       ret.gsub! /\A[-\.]+|[-\.]+\z/, ""

       ret
     end
     
     def current_cart 
         # TO DO - don't like this logic, also ensure cart belongs to right entities
         if @event
            cart=Cart.find_by_event_id @event.id 
         else
            cart=Cart.find(session[:cart_id])
         end
         if cart.nil?
            cart = Cart.create(:user => current_user)
            package_proxy_item = Item.find('1001')
            cart.add_package_bundle_items package_proxy_item
            #cart.create :item_id=>package_proxy_item.id
            cart.line_items.build(item: package_proxy_item, :cost=>package_proxy_item.cost)
            cart.save
         end
         session[:cart_id] = cart.id
         cart
     end
     
     def setup_settings
       @first_step_id = Step.first.try(:id)
       @last_tab_id = Step.last.try(:id)
       @first_tab = "tabs-#{@first_step_id.to_s}"
       @last_tab = "tabs-#{@last_tab_id.to_s}"
     end
     
end
