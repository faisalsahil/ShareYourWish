require 'spec_helper'

describe GuestsController do
  
  let :birthday do
    mock_model(Event)
  end

  let :john do
    mock_model(Guest, :save => true, :id => 154, :event => birthday)
  end
  
  describe "GET 'show'" do
    it "returns http success" do
      Guest.should_receive(:find).with(john.id.to_s).and_return(john)
      get :show, :id => john.id
      response.should be_success
      response.should render_template(:show)
      assigns(:guest).should eql john
      assigns(:event).should eql birthday
    end
  end
  
   describe "GET 'edit'" do
    it "returns http success" do
      Guest.should_receive(:find).with(john.id.to_s).and_return(john)
      get 'edit', :id => john.id
      response.should be_success
      response.should render_template(:edit)
      assigns(:guest).should eql john
      assigns(:event).should eql birthday
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      guest = FactoryGirl.build(:guest)
      params = {:full_name => guest.full_name, :email => guest.email, :attendance => Guest::ATTENDANCES.keys[0] }
      post :create, :format => 'json', :guest => params
      response.should be_success
      assigns(:guest).should be_present
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      params = {:full_name => guest.full_name}
      put 'update', :format => 'json', :id => guest.id, :guest => params
      response.should be_success
      assigns(:guest).should be_present
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      Guest.should_receive(:find).with(john.id.to_s).and_return(john)
      delete 'destroy', :id => john.id
      response.should redirect_to guests_path
    end
  end
  
  describe "POST 'invite'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      expect {
        post :invite, :id => guest.id
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      response.should redirect_to guest
    end
  end
  
  describe "POST 'remind'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      expect {
        post :remind, :id => guest.id
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      response.should redirect_to guest
    end
  end
  
   describe "POST 'thank'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      expect {
        post :thank, :id => guest.id
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      response.should redirect_to guest
    end
  end
  
  describe "POST 'custom'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      expect {
        post :custom, :id => guest.id, :subject => Faker::Lorem.sentence(3),  :title =>Faker::Lorem.sentence(5),  :body => Faker::Lorem.sentence(15)
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      response.should redirect_to guest
    end
  end
  
   describe "POST 'confirm_reminder'" do
    it "returns http success" do
      guest = FactoryGirl.create(:guest)
      expect {
        post :confirm_reminder, :id => guest.id
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      response.should redirect_to guest
    end
  end

  describe "GET 'uninvited'" do
    it "returns http success" do
      Guest.should_receive(:find).with(john.id.to_s).and_return(john)
      get :uninvited, :id => john.id
      response.should be_success
      response.should render_template(:uninvited)
      assigns(:guest).should eql john
      assigns(:event).should eql birthday
    end
  end

end
