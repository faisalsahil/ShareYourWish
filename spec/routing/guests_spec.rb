require 'spec_helper'

describe 'routing to guests' do
 
  before(:each) do
    @guest = create(:guest)
  end 
  
  # resources :guests, :only => [:show, :create, :update, :destroy] 
  # GET /guests/1
  it 'should route get /guests/1 to guests#show' do
    { :get => "/guests/#{@guest.id}" }.should route_to(
      :controller => 'guests',
      :action => 'show',
      :id => @guest.id.to_s
    )
  end
  
  # GET /guests/1.json
  it 'should route get /guests/1.json to guests#show' do
    { :get => "/guests/#{@guest.id}.json" }.should route_to(
      :controller => 'guests',
      :action => 'show',
      :format => 'json',
      :id => @guest.id.to_s
    )
  end
  
  # POST /guests
  it 'should route post /guests to /guests#create' do
    { :post => "/guests" }.should route_to(
      :controller => 'guests',
      :action => 'create'
    )
  end
 
  # POST /guests.json
  it 'should route post /guests.json to /guests#create' do
    { :post => "/guests.json" }.should route_to(
      :controller => 'guests',
      :action => 'create',
      :format => 'json'
    )
  end
  
  # PUT /guests/1
  it 'should route put /guests/1 to guests#update' do
    { :put => "/guests/#{@guest.id}" }.should route_to(
      :controller => 'guests',
      :action => 'update',
      :id => @guest.id.to_s
    )
  end
 
  # PUT /guests/1.json
  it 'should route put /guests/1.json to guests#update' do
    { :put => "/guests/#{@guest.id}.json" }.should route_to(
      :controller => 'guests',
      :action => 'update',
      :id => @guest.id.to_s, 
      :format => 'json'
    )
  end
  
  # DELETE /guests/1
  it 'should route delete /guests/1 to guests#destroy' do
    { :delete => "/guests/#{@guest.id}" }.should route_to(
      :controller => 'guests',
      :action => 'destroy',
      :id => @guest.id.to_s
    )
  end
   
  # DELETE /guests/1.json
  it 'should route delete /guests/1.json to guests#destroy' do
    { :delete => "/guests/#{@guest.id}.json" }.should route_to(
      :controller => 'guests',
      :action => 'destroy',
      :id => @guest.id.to_s, 
      :format => 'json'
    )
  end
  
  # match '/guests' => 'guests#destroy', :via => :delete,
  it 'should route delete /guests to guests#destroy' do
    { :delete => "/guests" }.should route_to(
      :controller => 'guests',
      :action => 'destroy'
    )
  end
  
  # match '/guests' => 'guests#create_or_update', :via => :put
  it 'should route put /guests to guests#create_or_update' do
    { :put => "/guests" }.should route_to(
      :controller => 'guests',
      :action => 'create'
    )
  end
 
  # PUT /guests/1.json
  it 'should route put /guests/1.json to guests#update' do
    { :put => "/guests/#{@guest.id}.json" }.should route_to(
      :controller => 'guests',
      :action => 'update',
      :id => @guest.id.to_s, 
      :format => 'json'
    )
  end

end