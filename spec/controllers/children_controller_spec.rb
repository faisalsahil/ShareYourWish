require 'spec_helper'
describe ChildrenController do

  describe "DELETE 'destroy'" do
    
    before :each do
      request.env["HTTP_REFERER"] = root_path
    end
    
    let :rita do
      mock_model(Child, :destroy => true, :id => 154, :guest_id => 123)
    end

    it "returns http success" do
      Child.should_receive(:find_by_id_and_guest_id).with(rita.id.to_s, rita.guest_id.to_s).and_return(rita)
      delete 'destroy', :id => rita.id, :guest_id => rita.guest_id
      response.should redirect_to(root_path)
    end
  end
  
end
