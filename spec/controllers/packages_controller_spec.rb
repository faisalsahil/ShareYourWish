require 'spec_helper'

describe PackagesController do

  before :each do
    controller.stubs(:current_user).returns(arnold)
    controller.stubs(:authenticate).returns(arnold)
    controller.stubs(:authenticate_user!).returns(true)
    Package.should_receive(:find_by_id).with(package_1.id.to_s).and_return(package_1)
  end
  
  let :arnold do
    FactoryGirl.build_stubbed(:guest, full_name: "Arnold")
  end
  
  let :package_1 do
    mock_model(Package, :save => true, :id => 154, :items => stubs(:present? => true))
  end

  describe "GET 'items'" do
    it "returns http success" do
      get 'items', :id => package_1.id
      response.should be_success
      assigns(:package).should eql package_1
    end
  end

end
