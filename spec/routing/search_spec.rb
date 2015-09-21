require 'spec_helper'

describe 'routing to search' do

  # match '/search' => 'search#index'
  it 'should route get search to search#index' do
    { :get => "/search" }.should route_to(
      :controller => 'search',
      :action => 'index'
    )
  end
  
  # match '/search' => 'search#index'
  it 'should route post search to search#index' do
    { :post => "/search" }.should route_to(
      :controller => 'search',
      :action => 'index'
    )
  end
  
end