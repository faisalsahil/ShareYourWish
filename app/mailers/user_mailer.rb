class UserMailer < ActionMailer::Base
  helper :application
  default from: APP_CONFIG['from']

  def welcome(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to ShareYourWish!")
  end
  
  def release_gift_fund(user,event)
    @user = user
    @event = event
    mail(:to => user.email, :subject => "ShareYourWish Event Update")
  end
  
  def day_of_event(user,event)
    @user = user
    @event = event
    mail(:to => user.email, :subject => "ShareYourWish Event Update")
  end
  
  def release_donation_fund(user,event)
    @user = user
    @event = event
    mail(:to => user.email, :subject => "ShareYourWish Event Update ")
  end

end
