require 'spec_helper'

describe 'routing to items' do 
 
  before(:each) do
    @item = create(:item) 
  end 

  # match '/items/:id' => 'items#show', :via => :get, :as => :item
  it 'should route /items/:id to items#show' do
    { :get => "/items/#{@item.id}" }.should route_to(
      :controller => 'items',
      :action => 'show',
      :id => @item.id.to_s
    )
  end
   
end