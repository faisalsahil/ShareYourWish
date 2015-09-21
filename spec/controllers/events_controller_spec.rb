require 'spec_helper'

describe EventsController do
  before :each do
    controller.stubs(:current_user).returns(boria)
    controller.stubs(:authenticate).returns(boria)
    controller.stubs(:authenticate_user!).returns(true)
    boria.expects(:role).returns(:user)
    request.env["HTTP_REFERER"] = root_path
  end
  
  let :boria do
    mock_model(User, :id => 144)
  end
  let :event do
    FactoryGirl.create(:event)
  end
  context "#index" do
    it "get :index should be success" do
      get :index
      response.should be_success
    end
    
    it "redirects to new_user_registration_path" do
      controller.stubs(:current_user).returns(nil)
      controller.stubs(:authenticate).returns(nil)
      controller.stubs(:authenticate_user!).returns(false)
      get :index
      response.should redirect_to(new_user_registration_path)
    end
    
  end
  
  context "#new"
  context "#show"
  context "#dashboard"
  context "#edit"
  context "#create"
  context "#update"
  context "#destroy"
  context "#visitor_entrance"
  context "#clear_cart"
  context "#steps_states"
  context "#invite"
  
  context "#release_gift_fund" do 
    it "create log gift_fund_disbursement after visit release_gift_fund_event_path" do
      post :release_gift_fund, :id => event.id
      response.should redirect_to(root_path)
    end
  end
  
  context "#release_donation_fund" do 
    it "create log donation_fund_disbursement after visit release_donation_fund_event_path" do
      post :release_donation_fund, :id => event.id
      response.should redirect_to(root_path)
    end
  end
  
  context "#charities"
  context "#guests"
  context "#invite"
    
end
