require 'open-uri'
class Child < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :guest, :inverse_of => :children
  belongs_to :event, :inverse_of => :children
  validates :name, :presence => { :message=>"Please include Child Name" }
  validates :dob, :presence => { :message=>"Please include Child Birthday" }, :unless => :is_invited?
  validates :dob, :date => {:before => Proc.new { Date.today }, :message => "Date of Birth appears invalid" }, :allow_blank => true
  attr_accessible :name, :dob, :event, :guest, :event_id, :guest_id
  validates_presence_of :guest
  validates_presence_of :event
  
  scope :invited, where('event_id IS NOT NULL')
  scope :uninvited, where('event_id IS NULL')
  
  def is_invited?
    self.event.present?
  end
  
  def reward_certificate_path
    Rails.root.join('public', 'events', self.event.id.to_s, 'guests', self.guest.id.to_s, 'children', self.id.to_s, 'reward_certificate.pdf')
  end

end
