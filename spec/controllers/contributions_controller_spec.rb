require 'spec_helper'

describe ContributionsController do
  
  context "#create" do
     
    before :each do
      controller.stubs(:current_user).returns(arnold)
      controller.stubs(:authenticate).returns(arnold)
      request.env["HTTP_REFERER"] = root_path
    end
    
    let :arnold do
      FactoryGirl.build_stubbed(:guest, full_name: "Arnold")
    end
    
    it "redirects back after create" do
      arnold.expects(:role).returns(:visitor)
      post :create, :guest_id => arnold.id
      response.should redirect_to(root_path)
    end
    
  end

end
