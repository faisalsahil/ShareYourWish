class Guest < ActiveRecord::Base
  include ActionView::Helpers
  include Extensions::BraintreeSyw
  include ActiveModel::Dirty
  acts_as_paranoid
  belongs_to :event, :inverse_of => :guests, :include => :user
  belongs_to :user, :inverse_of => :guests
  has_one :contribution, :inverse_of => :guest
  belongs_to :lookup_guests_status, :inverse_of => :guests
  has_many :children, :inverse_of => :guest
  validates :attendance, :presence => true
  validates_uniqueness_of :email, :scope => [:email, :event_id]
  SECRET_PHRASE = 'sdfsdJYTus45'
  ANONYMOUS_ID = 999999
  ATTENDANCES = {:yes => 'Yes', :maybe => 'Maybe', :no => 'No', :no_reply => 'No Reply'}
  # TODO replace ATTENDANCES_TMP with ATTENDANCES
  ATTENDANCES_TMP = {:yes => 'Yes', :no => 'No', :no_reply => 'No Reply'}

  scope :visible, where(:hidden => false)
  scope :invite_not_sent, joins(:lookup_guests_status).where('lookup_guests_statuses.status_code' => :inviteNotSent)
  scope :invited, joins(:lookup_guests_status).where('lookup_guests_statuses.status_code' => [:inviteSentNoActivity, :hasVisitedSite, :hasRegisteredAccount, :hasRejectedDonation, :hasMadeDonation], :hidden => false)
  scope :yes, where(:attendance => ATTENDANCES.keys[0], :hidden => false)
  scope :no, where(:attendance => ATTENDANCES.keys[2], :hidden => false)
  scope :no_reply, where(:attendance => ATTENDANCES.keys[3], :hidden => false)

  before_create :create_guest_access_token
  after_update :log_status_changes

  attr_accessible :id, :full_name, :email, :user_id, :event_id, :hidden, :guest_access_token
  attr_accessible :lookup_guests_status_id, :attendance, :message, :children_attributes, :event
  accepts_nested_attributes_for :children, :reject_if => proc { |attributes| attributes['name'].blank? }

  before_update :lookup_guests_status_id_cant_be_lower_than_is
  before_destroy :check_for_contribution_existance

  def lookup_guests_status_id_cant_be_lower_than_is
    self.lookup_guests_status_id = self.lookup_guests_status_id_was if self.lookup_guests_status_id_changed? && self.lookup_guests_status_id < self.lookup_guests_status_id_was
  end

  def create_guest_access_token
    self.guest_access_token = Digest::MD5.hexdigest SECRET_PHRASE + self.email
  end

  def invite!
    raise Exception::StandardError, "Event must exist for sending invite!" if self.event.nil?
    lookup_guests_status = LookupGuestsStatus.find_by_status_code(:inviteSentNoActivity)
    self.update_attribute(:lookup_guests_status_id, lookup_guests_status.id) if GuestMailer.invite(self).deliver
  end


  def log_status_changes
    EventActivityLog::create_status_changes(self, self.log_as_anonymous?) if self.lookup_guests_status_id_changed?
  end

  def log_as_anonymous?
    self.lookup_guests_status.hasMadeDonation? && self.contribution.try(:anonymous?)
  end

  def anonymous?
    self.id == ANONYMOUS_ID
  end

  def contributed?
    self.contribution.present?
  end

  def can_delete_comment? comment
    return false if self.anonymous?
    return false unless self.persisted?
    return false unless comment.guest_id
    self.id == comment.guest_id
  end
  
  def contribution_text
    if self.contributed?
      self.contribution.anonymous? ? 'Undisclosed $' : number_to_currency(self.contribution.amount.to_s) + ' (about ' + number_to_currency(self.contribution_amount_less_fees) + ' after fees)'
    else
      self.lookup_guests_status.try(:hasRejectedDonation?) ? 'Declined' : 'No Response'
    end
  end
  
  def contribution_amount_less_fees
    t = self.contribution.amount*(1-Event::CC_FEE_PERCENT) - Event::CC_FEE_FIXED
    if self.contribution.pay_transaction_fee? == false
       t -= Contribution::TRANSACTION_FEE
    end
    return t
 end
  
  # We capture some children of a guest on the Dashboard (they are invited) but the guest can also
  # add more (uninvited) children to the list in order to receive a reminder at their birthday time
  def children_names invited = true
    invited ? children.invited.map(&:name) : children.map(&:name)
  end
    
  def invited_children
    children_names(true).to_sentence
  end

  def invited_guest_or_children
     # v0.9.13 we are no longer using Parents_Invited to infuence invitation line in emails
     # if self.event.parents_invited.to_sym == Event::PARENTS_INVITED.keys[2]
     if self.children_names(true).length >1
        invited_children + " are"
     elsif self.children_names(true).length >0
        invited_children + " is"
     else 
        "you are"
     end 
  end
  
  
  # Emails
     def remind!
       raise Exception::StandardError, "Event must exist for sending remind!" if self.event.nil?
       GuestMailer.remind(self).deliver
     end

     def remind_fortyeight!
       raise Exception::StandardError, "Event must exist for sending 48-hour remind!" if self.event.nil?
       GuestMailer.remind_fortyeight(self).deliver
     end

     def thank!
       raise Exception::StandardError, "Event must exist for sending thank!" if self.event.nil?
       GuestMailer.thank(self).deliver
     end

     def send_custom_message!(subject, title, body)
       raise Exception::StandardError, "Event must exist for sending custom message!" if self.event.nil?
       GuestMailer.custom(self, strip_tags(subject), strip_tags(title), strip_tags(body)).deliver
     end

     def confirm_reminder!
       raise Exception::StandardError, "Event must exist for sending confirm_reminder!" if self.event.nil?
       GuestMailer.confirm_reminder(self).deliver
     end


  private

  def check_for_contribution_existance
    if self.contribution.present?
      errors.add(:contribution, "We cannot delete guest while contribution present!")
      false
    end
  end

end
