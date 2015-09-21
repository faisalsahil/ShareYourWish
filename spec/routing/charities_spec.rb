require 'spec_helper'

describe 'routing to charities' do
 
  before(:each) do
    @charity = create(:charity)
  end 

  # match '/charities'                 => 'charities#index',      :via => :get
  it 'should route charities to charities#index' do
    { :get => "/charities" }.should route_to(
      :controller => 'charities',
      :action => 'index'
    )
  end
  
  #  match '/charity/:id'               => 'charities#show',       :via => :get
  it 'should route /charity/:id to charities#show' do
    { :get => "/charity/#{@charity.id}" }.should route_to(
      :controller => 'charities',
      :action => 'show',
      :id => @charity.id.to_s
    )
  end
  
end