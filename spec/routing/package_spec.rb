require 'spec_helper'

describe 'routing to packages' do
 
  before(:each) do
    @package = create(:package) 
  end 

  # match '/package/:id/items'         => 'packages#items',       :via => :get
  it 'should route /package/:id/items to packages#items' do
    { :get => "/package/#{@package.id}/items" }.should route_to(
      :controller => 'packages',
      :action => 'items',
      :id => @package.id.to_s
    )
  end
   
end 