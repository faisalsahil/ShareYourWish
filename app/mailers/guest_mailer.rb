class GuestMailer < ActionMailer::Base
  helper :guests
  helper :application
  default from: APP_CONFIG['from']

  def invite(guest)
    @guest = guest
    mail(:to => guest.email, :subject => "You're invited to #{@guest.event.title}!")
  end
  
  def remind(guest)
    @guest = guest
    mail(:to => guest.email, :subject => "Reminder: please respond to #{@guest.event.format_child_name}'s invitation at ShareYourWish")
  end  
  
  def remind_fortyeight(guest)
    @guest = guest
    mail(:to => guest.email, :subject => "#{@guest.event.title} is just two days away!")
  end
  
  def thank(guest)
    @guest = guest
    @event = @guest.event
    @guest.children.each do |child|
      attachments['#{child.name.slug}.pdf'] = ChildRewardsCertificate.new(:template => EventRewardsCertificate::TEMPLATE_PATH).to_pdf(child,@event)
    end
    mail(:to => guest.email, :subject => "Thank You on behalf of #{@guest.event.format_child_name} and ShareYourWish!")
  end
  
  def custom(guest, subject, title, body)
    @guest, @subject, @title, @body = guest, subject, title, body
    mail(:to => @guest.email, :subject => @subject)
  end
  
  def confirm_reminder(guest)
    @guest = guest
    mail(:to => guest.email, :subject => "ShareYourWish has received your reminder request!")
  end

end
