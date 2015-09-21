require 'spec_helper'

describe PicturesController do

  before :each do
    controller.stubs(:current_user).returns(arnold)
    controller.stubs(:authenticate).returns(arnold)
    controller.stubs(:authenticate_user!).returns(true)
    # Picture.should_receive(:find).with(picture_1.id.to_s).and_return(picture_1)
    # Picture.should_receive(:find_by_id).with(picture_1.id.to_s).and_return(picture_1)
  end
  
  let :arnold do
    mock_model(User, :full_name => "Arnold")
  end
  
  let :picture_1 do
    mock_model(Picture, :save => true, :id => 154, :to_jq_upload => {}, :destroy => true, :attributes => {"id" => "154"})
  end

  describe "GET 'index'" do
    it "returns http success" do
      Picture.should_receive(:all).and_return([picture_1])
      get :index, :format => 'json'
      response.should be_success
      assigns(:pictures).should eql [picture_1]
    end
  end
  
  describe "GET 'imageable_pictures'" do
    it "returns http success" do
      params = {:imageable_id => 'imageable_id', :imageable_type => 'imageable_type'}
      Picture.should_receive(:where).with(params).and_return([picture_1])
      get :imageable_pictures, params.merge({:format => 'json'})
      response.should be_success
      assigns(:pictures).should eql [picture_1]
    end
  end
  
  describe "GET 'show'" do
    it "returns http success" do
      Picture.should_receive(:find).with(picture_1.id.to_s).and_return(picture_1)
      get :show, :id => picture_1.id
      response.should be_success
      assigns(:picture).should eql picture_1
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      Picture.should_receive(:new).with(picture_1.attributes).and_return(picture_1)
      post :create, :picture => picture_1.attributes
      response.should be_success
      assigns(:picture).should be_present
    end
  end
  
  describe "PUT 'update'" do
    it "returns http success" do
      Picture.should_receive(:find).with(picture_1.id.to_s).and_return(picture_1)
      picture_1.should_receive(:update_attributes).with(picture_1.attributes).and_return(true)
      put 'update', :format => 'json', :id => picture_1.id, :picture => picture_1.attributes
      response.should be_success
      assigns(:picture).should be_present 
    end
  end
  
  describe "DELETE 'destroy'" do
    it "returns http success" do
      Picture.should_receive(:find).with(picture_1.id.to_s).and_return(picture_1)
      delete 'destroy', :id => picture_1.id
      response.should be_success
    end
  end

end
