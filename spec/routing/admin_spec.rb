require 'spec_helper'

describe 'routing to admin' do
  
  it 'should route /sywadmin be_routable' do
    { :get => '/sywadmin' }.should be_routable
  end

  it '/admin should_not be_routable' do
    pending
    { :get => '/admin' }.should_not be_routable
  end
  
end
