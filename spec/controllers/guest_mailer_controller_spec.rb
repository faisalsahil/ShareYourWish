require 'spec_helper'

describe GuestMailerController do
  subject { FactoryGirl.create(:guest) } 
  describe "GET 'invite'" do
    it "returns http success" do
      get :invite, :id => subject.id
      response.should be_success
    end
  end

  describe "GET 'remind'" do
    it "returns http success" do
      get :remind, :id => subject.id
      response.should be_success
    end
  end

  describe "GET 'thank'" do
    it "returns http success" do
      get :thank, :id => subject.id
      response.should be_success
    end
  end
  
  describe "GET 'custom'" do
    it "returns http success" do
      get :custom, :id => subject.id
      response.should be_success
    end
  end

end
