class Feedback < ActiveRecord::Base

  belongs_to :user, :inverse_of => :feedbacks
  validates :name, :email, :title, :message, :presence => true, :length => { :in => 2..255 }
  validates :email, :email => true
  attr_accessible :name, :email, :title, :message, :user_id
  after_create :send!
  def send!
    FeedbackMailer.contact_us(self).deliver
  end
end
