require 'spec_helper'

describe GuestsHelper do
  
  describe "methods" do
    
    subject { stub(:id => 127, :guest_access_token => 'ebfad71407ee721b756a9c3ccace3d26', :event => stub(:slug => 'event-slug')) }
    
    it "#invite_url" do
      helper.invite_url(subject).should eql 'http://test.host/events/event-slug/guest/127/invite/ebfad71407ee721b756a9c3ccace3d26#top'
    end
    
    it "#invite_path" do
      helper.invite_path(subject).should eql '/events/event-slug/guest/127/invite/ebfad71407ee721b756a9c3ccace3d26#top'
    end
    
  end
  
end
