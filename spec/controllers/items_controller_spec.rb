require 'spec_helper'

describe ItemsController do

  before :each do
    controller.stubs(:current_user).returns(arnold)
    controller.stubs(:authenticate).returns(arnold)
    controller.stubs(:authenticate_user!).returns(true)
    request.env["HTTP_REFERER"] = root_path
  end
  
  let :arnold do
    FactoryGirl.build_stubbed(:guest, full_name: "Arnold")
  end
  
  let :package_1 do
    mock_model(Package)
  end

  let :item_1 do
    mock_model(Item, :save => true, :id => 154, :package => package_1)
  end

  describe "GET 'show'" do
    it "returns http success" do
      Item.should_receive(:find_by_id).with(item_1.id.to_s).and_return(item_1)
      Package.should_receive(:find_by_id).with(package_1.id.to_s).and_return(package_1)
      get :show, :id => item_1.id, :package_id => package_1.id
      response.should be_success
      assigns(:item).should be_present
      assigns(:package).should be_present
    end
  end

end
