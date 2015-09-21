class FeedbackMailer < ActionMailer::Base
  default to: APP_CONFIG['admin_email']

  def contact_us(feedback)
    @feedback = feedback
    mail :from => feedback.email, :subject => 'SYW Feedback: ' + feedback.title
  end
end
