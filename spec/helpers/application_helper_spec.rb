require 'spec_helper'

describe ApplicationHelper do
  describe "methods" do
    
    it "#link_back" do
      helper.link_back('text', 'my_link').should eql '<a href="my_link">text</a>'
      session[:return_to_uri] = '/test/my'
      helper.link_back('text', :s => :six, :e => :eight).should eql '<a href="/test/my">text</a>'
    end
    
    it "#production?" do
      begin
        helper.production?.should be_false
        ENV['RAILS_ENV']='production'
        helper.production?.should be_true
      ensure
        ENV['RAILS_ENV']='test'
      end
    end
    
    it "#short" do
      text = Faker::Lorem.sentence(5)
      helper.short(text,120).should eql text[0..120]
    end
    
    it "#nl2br" do
      text = "\n my text "
      helper.nl2br(text).should eql '<br /> my text '
    end

    it "#current_event" do
      controller.stubs(:user_signed_in? => true)
      controller.stubs(:current_user => stub(:id => 123))
      event = mock(:event)
      Event.expects(:users_current_event).with(controller.current_user).returns(event)
      helper.current_event.should eql event
    end
    
    it "#first_word" do
      text = "first word"
      helper.first_word(text).should eql 'first'
    end
    
    it "#debug_enabled?" do
      helper.debug_enabled?.should be_false
      session[:debug]='opensesame'
      helper.debug_enabled?.should be_true
    end
    
    it "#clean_with_new_lines" do
      text = " <br><a>link</a> my text 123%&"
      helper.clean_with_new_lines(text).should == simple_format(text, {}, :sanitize => true)
    end
    
    it "#after_sign_out_path_for" do
      helper.after_sign_out_path_for('').should == 'http://test.host/'
    end
    
  end
end

