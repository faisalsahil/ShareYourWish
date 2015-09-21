require 'spec_helper'

describe 'routing to carts' do
 
  before(:each) do
    @cart = create(:cart) 
  end 
  
  # resources :carts, :only => [:show, :create, :update, :destroy] 
  # GET /carts/1
  it 'should route get /carts/1 to carts#show' do
    pending
    { :get => "/carts/#{@cart.id}" }.should route_to(
      :controller => 'carts',
      :action => 'show',
      :id => @cart.id.to_s
    )
  end
   
  # GET /carts/1.json
  it 'should route get /carts/1.json to carts#show' do
    pending
    { :get => "/carts/#{@cart.id}.json" }.should route_to(
      :controller => 'carts',
      :action => 'show',
      :format => 'json',
      :id => @cart.id.to_s
    )
  end
  
  # POST /carts
  it 'should route post /carts to /carts#create' do
    pending
    { :post => "/carts" }.should route_to(
      :controller => 'carts',
      :action => 'create'
    )
  end
 
  # POST /carts.json
  it 'should route post /carts.json to /carts#create' do
    pending
    { :post => "/carts.json" }.should route_to(
      :controller => 'carts',
      :action => 'create',
      :format => 'json'
    )
  end
  
  # PUT /carts/1
  it 'should route put /carts/1 to carts#update' do
    pending
    { :put => "/carts/#{@cart.id}" }.should route_to(
      :controller => 'carts',
      :action => 'update',
      :id => @cart.id.to_s
    )
  end
 
  # PUT /carts/1.json
  it 'should route put /carts/1.json to carts#update' do
    pending
    { :put => "/carts/#{@cart.id}.json" }.should route_to(
      :controller => 'carts',
      :action => 'update',
      :id => @cart.id.to_s, 
      :format => 'json'
    )
  end
  
  # DELETE /carts/1
  it 'should route delete /carts/1 to carts#destroy' do
    pending
    { :delete => "/carts/#{@cart.id}" }.should route_to(
      :controller => 'carts',
      :action => 'destroy',
      :id => @cart.id.to_s
    )
  end
   
  # DELETE /carts/1.json
  it 'should route delete /carts/1.json to carts#destroy' do
    pending
    { :delete => "/carts/#{@cart.id}.json" }.should route_to(
      :controller => 'carts',
      :action => 'destroy',
      :id => @cart.id.to_s, 
      :format => 'json'
    )
  end
  
  # match '/carts' => 'carts#destroy', :via => :delete,
  it 'should route delete /carts to carts#destroy' do
    pending
    { :delete => "/carts" }.should route_to(
      :controller => 'carts',
      :action => 'destroy'
    )
  end
  
  # match '/carts' => 'carts#create_or_update', :via => :put
  it 'should route put /carts to carts#create_or_update' do
    pending
    { :put => "/carts" }.should route_to(
      :controller => 'carts',
      :action => 'create_or_update'
    )
  end
 
  # PUT /carts/1.json
  it 'should route put /carts/1.json to carts#update' do
    pending
    { :put => "/carts/#{@cart.id}.json" }.should route_to(
      :controller => 'carts',
      :action => 'update',
      :id => @cart.id.to_s, 
      :format => 'json'
    )
  end

end