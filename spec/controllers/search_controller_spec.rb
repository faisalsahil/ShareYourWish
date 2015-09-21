require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', :q => 'something'
      response.should be_success
    end
  end

end
