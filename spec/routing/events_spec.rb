require 'spec_helper'

describe 'routing to events' do
 
  before(:each) do
    @event = create(:event)
    @step  = Step.first
    @user  = User.last
  end 
  
  # match '/events/user/:user_id/new/'  => 'events#new', :via => :get,  :as => :new_event
  it 'should route /events/user/:user_id/new/ to events#new' do
    { :get => "/events/user/#{@user.id}/new" }.should route_to(
      :controller => 'events',
      :action => 'new',
      :user_id => @user.id.to_s
    )
  end
  
  # resources :events, :only => [:show, :create, :update, :destroy]
  
  # GET /events/1
  it 'should route get /events/:id to events#show' do
    { :get => "/events/#{@event.id}" }.should route_to(
      :controller => 'events',
      :action => 'show',
      :id => @event.id.to_s
    )
  end
  
  # GET /events/1.json
  it 'should route get /events/:id.json to events#show' do
    { :get => "/events/#{@event.id}.json" }.should route_to(
      :controller => 'events',
      :action => 'show',
      :id => @event.id.to_s, 
      :format => 'json'
    )
  end
  
  # POST /events.json
  it 'should route post /events.json to events#create' do
    { :post => "/events.json" }.should route_to(
      :controller => 'events',
      :action => 'create',
      :format => 'json'
    )
  end
  
  # PUT	/events/:id.json
  it 'should route put /events/:id.json to events#update' do
    { :put => "/events/#{@event.id}.json" }.should route_to(
      :controller => 'events',
      :action => 'update',
      :id => @event.id.to_s, 
      :format => 'json'
    )
  end
  
  # DELETE /events/1
  it 'should route delete /events/:id to events#destroy' do
    { :delete => "/events/#{@event.id}" }.should route_to(
      :controller => 'events',
      :action => 'destroy',
      :id => @event.id.to_s
    )
  end
  # DELETE /events/1.json
  it 'should route delete /events/:id.json to events#destroy' do
    { :delete => "/events/#{@event.id}.json" }.should route_to(
      :controller => 'events',
      :action => 'destroy',
      :id => @event.id.to_s, 
      :format => 'json'
    )
  end
  
  # match '/events/:id/clear_carts'     => 'events#clear_carts',    :via => :post, :as => :event_clear_carts
  it 'should route post /events/#{@event.id}/clear_carts to events#clear_carts' do
    { :post => "/events/#{@event.id}/clear_carts" }.should route_to(
      :controller => 'events',
      :action => 'clear_carts',
      :id => @event.id.to_s
    )
  end

  # match '/events/:event_id/dashboard/event_activity_logs(/page/:page)' => 'event_activity_logs#index'
  it 'should route get /events/#{@event.id}/dashboard/event_activity_logs to event_activity_logs#index' do
    { :get => "/events/#{@event.id}/dashboard/event_activity_logs" }.should route_to(
      :controller => 'event_activity_logs',
      :action => 'index',
      :event_id => @event.id.to_s
    )
  end

  # match '/events/:id/dashboard(/event_activity_logs(/page/:page))' => 'events#dashboard',    :via => :get, :as => :event_dashboard
  it 'should route get /events/#{@event.id}/dashboard to events#dashboard' do
    { :get => "/events/#{@event.id}/dashboard" }.should route_to(
      :controller => 'events',
      :action => 'dashboard',
      :id => @event.id.to_s 
    )
  end

  # match '/events/:slug/guest/:guest_id/invite/:guest_access_token' => 'events#invite', :via => :get, :as => :event_guest_invite
  it 'should route get /events/:slug/guest/:guest_id/invite/:guest_access_token to events#invite' do
    guest = FactoryGirl.create(:guest, :event => @event)
    { :get => "/events/#{@event.slug}/guest/#{guest.id}/invite/#{guest.guest_access_token}" }.should route_to(
      :controller => 'events',
      :action => 'invite',
      :guest_id => guest.id.to_s,
      :guest_access_token => guest.guest_access_token.to_s,
      :slug => @event.slug.to_s
    )
  end

end