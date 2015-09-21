Shareyourwish::Application.routes.draw do

  resources :help_messages do
    get 'code/:code', :action => :show, :on => :collection
  end
  resources :subscribers
  resources :authentications

  get '/posts(/page/:page)' => 'posts#index', :as => :posts
  get '/posts/tags' => 'posts#tags', :as => :posts_tags
  get '/posts/tags/:tag_id(/page/:page)' => 'posts#index', :as => :posts_tag

  get '/posts/:posts_category_id/tags' => 'posts#show', :as => :posts_category_tags
  get '/posts/:posts_category_id/tags/:tag_id(/page/:page)' => 'posts#index', :as => :posts_category_tag

  get '/posts/:posts_category_id(/page/:page)' => 'posts#index', :as => :posts_category
  get '/posts/:posts_category_id/:post_id' => 'posts#show', :as => :post

  resources :comments
  resources :items
  resources :line_items
  resources :orders

  resources :events, :only => [:index, :create, :update, :destroy] do
    resources :comments, :event_activity_logs do
      get 'page/:page', :action => :index, :on => :collection
    end
    resources :charities do
      get '/:page', :action => :show, :on => :member
    end
    member do
      match :visitor_entrance
      match :invitation_insert
      post :clear_carts
      get :steps_states, :format => :json
      #get :guests
      post :release_gift_fund
      post :release_donation_fund
      get :reward_certificate
    end
    resources :guests do
      resources :children do
        member do
          get :reward_certificate
        end
      end
    end
  end
  post 'validate/event/:id/:property' => 'validate#event_valid?', :as => :validate_event
  get '/events/:id(/comments(/page/:page))' => 'events#show', :via => :get, :constraints => {:id => /[0-9]+/}
  get '/events/:slug(/comments(/page/:page))' => 'events#show', :via => :get
  match '/events/user/:user_id/new/' => 'events#new', :via => [:get, :post], :as => :new_event
  match '/events/:id/edit/user/:user_id/' => 'events#edit', :via => [:get, :post], :as => :edit_event
  match '/events/:id/steps_states.json' => 'events#steps_states', :via => :get, :as => :event_steps_states
  match '/events/:event_id/dashboard/event_activity_logs(/page/:page)' => 'event_activity_logs#index'
  match '/events/:id/dashboard(/event_activity_logs(/page/:page))' => 'events#dashboard', :via => :get, :as => :event_dashboard
  match '/events/:slug/guest/:guest_id/invite/:guest_access_token' => 'events#invite', :via => :get, :as => :event_guest_invite
  match '/events/:slug/guest/:guest_id/:guest_access_token/comments(/page/:page)' => 'comments#index'
  match '/events/:slug/guest/:guest_id/:guest_access_token(/comments(/page/:page))' => 'events#show', :as => :event_guest_show

  match '/charities' => 'charities#index', :via => :get, :as => :charities
  match '/charity/:id(/:page)' => 'charities#show', :via => :get, :as => :charity
  match '/charities/:event_id' => 'charities#event_charities', :via => :get, :as => :event_charities

  #match '/items/:id'                 => 'items#show',           :via => :get,   :as => :item
  match '/package/:id/items' => 'packages#items', :via => :get, :as => :package_items

  get "/pictures/:imageable_id" => "pictures#index", :as => :pictures
  post "/pictures/:imageable_id" => "pictures#create"
  delete "/pictures/:imageable_id/:id" => "pictures#destroy", :as => :picture

  resources :carts, :only => [:show, :create, :update, :destroy]
  match '/carts' => 'carts#create_or_update', :via => :put, :as => :create_or_update_cart
  match '/carts' => 'carts#destroy', :via => :delete, :as => :destroy_by_params_cart

  match 'payments/new' => 'payments#new', :as => :new_payment
  match 'payments/confirm' => 'payments#confirm', :as => :confirm_payment

  get "/guest_mailer/invite/:id" => "guest_mailer#invite", :as => :guest_mailer_invite
  get "/guest_mailer/remind/:id" => "guest_mailer#remind", :as => :guest_mailer_remind
  get "/guest_mailer/thank/:id" => "guest_mailer#thank", :as => :guest_mailer_thank
  get "/guest_mailer/custom/:id" => "guest_mailer#custom", :as => :guest_mailer_custom

  resources :guests do
    member do
      post :invite
      post :remind
      post :thank
      post :custom
      post :confirm_reminder
      get :uninvited
    end
    resources :contributions
    resources :children do
      member do
        get :reward_certificate
      end
    end
  end
  match '/guests' => 'guests#create', :via => :put, :as => :create_guest
  match '/guests' => 'guests#destroy', :via => :delete, :as => :destroy_by_params_guest

  match '/feed' => 'posts#feed',
    :as => :feed,
    :defaults => {:format => 'atom'}

  get '/search' => 'search#index'
  post '/search' => 'search#by_magic_phrase'

  match "/users/auth/:provider/callback" => "authentications#create"
  # we are going to interecept the omniauth_callback route... at the expense of not getting that helper method... and take the
  # input as :provider instead of :action, so we don't write a separate non-restful method for each different provider we support

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_scope :user do
    get '/users/auth/:provider' => 'authentications#passthru'
    get '/users/logout' => 'devise/sessions#destroy'
  end

  devise_for :users,
    :path_names => {
      :sign_up => "register",
      :sign_in => "login",
      :sign_out => "logout"
    },
    :controllers => {
      :registrations => "registrations"
    #:omniauth_callbacks => "authentications"  # This is what makes the /users/auth/:ACTION/callback route and helper method
    }

  resources :users, :only => [:show, :edit, :update]

  # default page processing - if not already routed, let Pages controller figure out if it's a static page
  # match ':section(/:page)' => 'pages#show'
  resources :feedbacks
  get '/400' => 'errors#bad_request' # 400
  get '/401' => 'errors#unauthorized' # 401
  get '/404' => 'errors#not_found' # 404
  get '/500' => 'errors#internal_server_error' # 500
  match '/contact-us' => 'feedbacks#new', :as => :contact_us
  match '/browse/charities' => 'charities#browse'
  match '/*page' => 'pages#show', :as => :pages

  root :to => 'pages#index'

end
