require 'spec_helper'

describe EventHelper do
  
  describe "methods" do
    
    subject { mock(:event) }
    
    it "#hours_options" do
      subject.expects(:event_date).returns(DateTime.parse('2012-12-18 14:05:00 UTC'))
      helper.hours_options(subject.event_date.to_s).should eql "<option>01</option><option>02</option><option>03</option><option selected>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option><option>12</option>"
    end

    it "#minutes_options" do
      subject.expects(:event_date).returns(DateTime.parse('2012-12-26 12:15:00 UTC'))
      helper.minutes_options(subject.event_date.to_s).should == "<option>00</option><option selected>15</option><option>30</option><option>45</option>"
    end

    it "#noon_options" do
      subject.expects(:event_date).returns(DateTime.parse('2012-11-16 17:55:00 GMT'))
      helper.noon_options(subject.event_date.to_s).should == "<option>AM</option><option selected>PM</option>"
    end

    it "#charities_select_tag" do
      charities = []
      3.times do |i|
        charities << stub(:id => i, :name => "Char #{i}")
      end
      helper.charities_select_tag(charities).should eql "<select id=\"charities\" name=\"charities\"><option value=\"0\">Char 0</option>\n<option value=\"1\">Char 1</option>\n<option value=\"2\">Char 2</option></select>"
    end
    
    it "#guests_select_tag" do
      guests = []
      3.times do |i|
        guests << stub(:id => i, :full_name => "Guest #{i}")
      end
      helper.guests_select_tag(guests).should == "<select id=\"charities\" name=\"charities\"><option value=\"0\">Guest 0</option>\n<option value=\"1\">Guest 1</option>\n<option value=\"2\">Guest 2</option></select>"
    end
    
  end

end
