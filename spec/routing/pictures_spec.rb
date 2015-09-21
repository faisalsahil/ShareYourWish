require 'spec_helper'

describe 'routing to pictures' do
 
  before(:each) do
    @picture = create(:picture) 
    @event = create(:event)
  end 

  # GET /pictures 
  it 'should route get /pictures to pictures#index' do
    pending
    { :get => "/pictures" }.should route_to(
      :controller => 'pictures',
      :action => 'index'
    )
  end
  
  #  match '/pictures/:imageable_id/:imageable_type' => 'pictures#imageable_pictures', :via => :get
  it 'should route get /pictures/:imageable_id/:imageable_type to pictures#imageable_pictures' do
    pending
    { :get => "/pictures/#{@event.id}/event" }.should route_to(
      :controller => 'pictures',
      :action => 'imageable_pictures',
      :imageable_id => @event.id.to_s,
      :imageable_type => 'event'
    )
  end
  
  #  resources :pictures, :only => [:index, :create, :update, :destroy]
  # POST /pictures.json
  it 'should route post /pictures.json to pictures#create' do
    pending
    { :post => "/pictures.json" }.should route_to(
      :controller => 'pictures',
      :action => 'create',
      :format => 'json'
    )
  end
  
  # PUT /pictures/1.json
  it 'should route put /pictures/1.json to pictures#update' do
    pending
    { :put => "/pictures/#{@picture.id}.json" }.should route_to(
      :controller => 'pictures',
      :action => 'update',
      :id => @picture.id.to_s, 
      :format => 'json'
    )
  end
  
  # DELETE /pictures/1.json
  it 'should route delete /pictures/1.json to pictures#destroy' do
    pending
    { :delete => "/pictures/#{@picture.id}.json" }.should route_to(
      :controller => 'pictures',
      :action => 'destroy',
      :id => @picture.id.to_s, 
      :format => 'json'
    )
  end
   
end