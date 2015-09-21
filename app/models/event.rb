require 'open-uri'

class Event < ActiveRecord::Base

  include Validation::Event

  CC_FEE_PERCENT = 0.029
  CC_FEE_FIXED = 0.30
  SYW_FEE = 2.0
  GIFT_FUND_UNLOCK_DAYS = -7
  DONATION_FUND_UNLOCK_DAYS = 3
  CONTRIBUTIONS_LOCK_DAYS = 3
  RSVP_BY_DAYS = -10
  PARENTS_INVITED = {:required => 'Required', :optional => 'Optional', :drop_off_only => 'Drop Off Only'}
  acts_as_paranoid
  acts_as_commentable
  belongs_to :user, :inverse_of => :events
  belongs_to :theme, :foreign_key => :theme_code, :inverse_of => :events
  has_many :pictures, :as => :imageable

  has_many :guests, :inverse_of => :event, :dependent => :destroy
  has_and_belongs_to_many :charities
  belongs_to :package, :inverse_of => :events
  has_one :cart, :inverse_of => :event
  belongs_to :step, :inverse_of => :events
  has_many :event_activity_logs, :inverse_of => :event
  has_many :contributions, :inverse_of => :event
  belongs_to :lookup_event_sequence, :inverse_of => :events, :foreign_key => :event_sequence
  has_many :children, :inverse_of => :event
  has_many :event_transaction_logs, :inverse_of => :event
  has_one :order, :inverse_of => :event

  attr_accessible(
    :step, :slug, :charity_ids, :package_id, :magic_phrase, :status, :user, :package, :theme_code, :host_name,
    :step_id, :state, :page_content_one, :page_content_two, :page_content_three, :page_content_four, :other_page_content,
    :title, :child_full_name, :child_pronoun, :child_dob, :child_dob, :event_date, :start_time, :end_time, :charity_donation_percent,
    :created_at, :updated_at, :parental_consent_status, :user_id, :contributions_locked, :rsvp_by, :parents_invited,
    :location_name, :location_address, :event_sequence, :gift_fund_locked, :donation_fund_locked, :publicly_viewable, :invite_option
  )

  before_validation :setup_slug!, :if => :title?, :unless => :slug?

  scope :with_locked_funds, where('gift_fund_locked = 1 OR donation_fund_locked = 1')
  scope :with_unlocked_contributions, where(:contributions_locked => false)
  scope :by_updated, order(:updated_at).reverse_order
  scope :complete_or_open, where(:state => ['complete', 'open'])
  scope :within_fortyeight_hours, where('datediff( event_date, curdate() ) = 2')

  after_create :open_balance_log
  after_create :new_event_created_log
  # future - this should not be. We don't want to track current step for Event... in the EventMachine we want to allow user to jump betwen steps, it's not forward-only. But the currently implementation is not yet to that spec
  before_update :step_id_cant_be_lower_than_is

  self.per_page = 10

  def open_balance_log
    EventTransactionLog::open_balance(self)
  end

  def new_event_created_log
    EventActivityLog::new_event_created(self)
  end

  def publicly_viewable?
    self.publicly_viewable
  end

  def setup_slug!
    self.slug = self.title.slug+'-'+self.id.to_s if self.title
  end

  def joint_party?
    self.child_pronoun && self.child_pronoun.downcase=='they'
  end

  def step_id_cant_be_lower_than_is # this logic is wrong, don't use this
    self.step_id = self.step_id_was if self.step_id_changed? && self.step_id < self.step_id_was
  end

  def self.users_in_progress_event user
    r = Event.where(:status => :in_progress, :user_id => user.id)
    r.empty? ? false : r.first
  end

  def self.users_current_event user
    r = Event.where(:user_id => user.id).order("created_at DESC")
    r.empty? ? nil : r.first
  end

  def self.users_published_events user
    Event.where(:status => :published, :user_id => user.id)
  end

  def start_time
    read_attribute(:start_time) ? I18n.localize(read_attribute(:start_time), :format => :default) : nil
  end

  def end_time
    read_attribute(:end_time) ? I18n.localize(read_attribute(:end_time), :format => :default) : nil
  end

  def shown_guests
    Guest.where(:hidden => false, :event_id => self.id).reverse_order
  end

  def hidden_guests
    Guest.where(:hidden => true, :event_id => self.id)
  end

  def get_state step
    return nil unless self.step && step

    if self.step.order < step.order
      unless self.step.must_complete? && self.state != 'complete'
        Step.has_must_complete_before_event_step?(self.step, step) ? 'not_ready' : 'open'
      else
        'not_ready'
      end
    elsif self.step.eql? step
      case self.state
        when 'open' then
          'open'
        when 'not_ready' then
          'not_ready'
        when 'complete' then
          self.step.locked_on_completion && self.published? ? 'complete_and_locked' : 'complete'
      end
    else #self.step.order > step.order
      step.locked_on_completion && self.published? ? 'complete_and_locked' : 'complete'
    end

  end

  def get_state_message step
    return nil unless self.step && step

    case self.get_state step
      when 'open' then
        "Step open to edit"
      when 'not_ready' then
        "Please complete Step #{step.previous_must_complete.title} before continuing"
      when 'complete' then
        "Step completed"
      when 'complete_and_locked' then
        "Step completed and locked"
    end
  end

  def get_state_css_class step
    return nil unless self.step && step

    case self.get_state step
      when 'open' then
        'state-open'
      when 'not_ready' then
        'state-not-ready'
      when 'complete' then
        'state-complete'
      when 'complete_and_locked' then
        'state-complete-and-locked'
    end
  end

  def get_state_at_complete step
    return nil unless self.step && step
    if self.step.eql? step
      self.step.locked_on_completion ? 'state-complete-and-locked' : 'state-complete'
    else
      step.locked_on_completion ? 'state-complete-and-locked' : 'state-complete'
    end
  end

  def complete_and_locked? step
    self.get_state(step).eql?('complete_and_locked')
  end

  def steps_states
    states = []
    Step.all.each do |step|
      states << {:id => step.id, :state => self.get_state_css_class(step), :message => self.get_state_message(step)}
    end
    states
  end

  def start_time_formated format = "%I:%M%P"
    DateTime.parse(self.start_time).strftime(format)
  end

  def end_time_formated format = "%I:%M%P"
    DateTime.parse(self.end_time).strftime(format)
  end

  def contributions_total_amount
    self.contributions.sum(:amount).round(2)
  end

  def contributions_total_amount_after_fees
    (self.gift_fund + self.donation_fund).round(2)
  end

  # funds
  def event_fund
    return 0.0 unless self.event_transaction_logs.present?
    self.event_transaction_logs.sum(:event_fund).round(2)
  end

  def gift_fund
    return 0.0 unless self.event_transaction_logs.present?
    self.event_transaction_logs.sum(:gift_fund).round(2)
  end

  def donation_fund
    return 0.0 unless self.event_transaction_logs.present?
    self.event_transaction_logs.sum(:donation_fund).round(2)
  end

  def syw_fund
    return 0.0 unless self.event_transaction_logs.present?
    self.event_transaction_logs.sum(:syw_fund).round(2)
  end

  def gift_fund_days_to_unlock
    r = (self.event_date + GIFT_FUND_UNLOCK_DAYS.days).to_date.jd - Date.today.jd
    r < 0 ? 0 : r
  end

  def donation_fund_days_to_unlock
    r = (self.event_date + DONATION_FUND_UNLOCK_DAYS.days).to_date.jd - Date.today.jd
    r < 0 ? 0 : r
  end

  def contributions_days_to_lock
    r = (self.event_date + CONTRIBUTIONS_LOCK_DAYS.days).to_date.jd - Date.today.jd
    r < 0 ? 0 : r
  end

  def event_days_to_go
     r = self.event_date.to_date.jd - Date.today.jd
     r < 0 ? 0 : r
  end
  
  def gift_fund_lock!
    self.update_attribute(:gift_fund_locked, true)
  end

  def gift_fund_unlock!
    self.update_attribute(:gift_fund_locked, false)
    self.set_event_sequence_by_code :release_gift_fund
  end

  def donation_fund_lock!
    self.update_attribute(:donation_fund_locked, true)
  end

  def donation_fund_unlock!
    self.update_attribute(:donation_fund_locked, false)
    self.set_event_sequence_by_code :release_donation_fund
  end

  def contributions_lock!
    self.update_attribute(:contributions_locked, true)
  end

  def contributions_unlock!
    self.update_attribute(:contributions_locked, false)
  end

  def funds_unlock!
    self.gift_fund_unlock! && self.donation_fund_unlock!
  end

  def funds_lock!
    self.gift_fund_lock! && self.donation_fund_lock!
  end

  def funds_unlock_if_eligible!
    self.gift_fund_unlock! if self.gift_fund_days_to_unlock <= 0
    self.donation_fund_unlock! if self.donation_fund_days_to_unlock <= 0
  end

  def contributions_lock_if_eligible!
    self.contributions_lock! if self.contributions_days_to_lock <= 0
  end

  def gift_fund_locked?
    self.gift_fund_locked
  end

  def donation_fund_locked?
    self.donation_fund_locked
  end

  def contributions_locked?
    self.contributions_locked
  end


  def set_event_sequence_by_code(target_code, override=false)
    target_state = LookupEventSequence.find_by_code target_code
    if !target_state.nil? && ((target_state.sequence > self.event_sequence) || override)
      self.update_attribute(:event_sequence, target_state.sequence)
      self.user.event_updated!(self)
    end
  end

  def owner? user
    return false unless user.is_a? User
    self.user === user
  end

  def theme_current? theme
    return false unless theme.is_a? Theme
    self.theme_code === theme.code
  end

  def in_progress?
    self.status == 'in_progress'
  end

  def published?
    self.status == 'published'
  end

  def publish!
    self.update_attribute(:status, 'published') unless self.published?
    self.set_event_sequence_by_code('send_invitations')
    EventActivityLog::new_event_published(self)
  end

  def self.search query, page = 1, searchers = [:location_name, :child_full_name, :title], where = []
    return [] unless query.length
    searchers.each do |s|
      where << sprintf("%s LIKE %s", s.to_s, ActiveRecord::Base.connection.quote("%#{query.to_s}%"))
    end
    Event.paginate(:page => page, :per_page => self.per_page, :conditions => where.join(' OR '))
  end

  def magic_phrase_valid? magic_phrase
    return false unless self.magic_phrase
    self.magic_phrase.to_s.downcase.strip == magic_phrase.to_s.downcase.strip
  end

  # it's hard to remember which array position is for which term
  def format_child_pronouns
    r=[]
    if self.child_pronoun
       case self.child_pronoun.downcase
         when 'male'
           r[0]='he'
           r[1]='him'
           r[2]='his'
           r[3]='boy'
         when 'female'
           r[0]='she'
           r[1]='her'
           r[2]='her'
           r[3]='girl'
         when 'they'
           r[0]='they'
           r[1]='them'
           r[2]='their'
           r[3]='kids'
       end
     end
    r
  end

  # example: @event.format_child_name('is','are')
  def format_child_name singular_phrase='', plural_phrase=''
    if self.child_full_name.present?
       name = self.child_full_name
    else
       name = "MissingName"
    end
    if singular_phrase!=''
      singular_phrase = ' ' + singular_phrase
    end
    if plural_phrase!=''
      plural_phrase = ' ' + plural_phrase
    end
    if self.joint_party?
      name + plural_phrase
    else
      name.first_word + singular_phrase
    end
  end

  private

  def title?
    self.title.present?
  end

  def slug?
    self.slug.present?
  end

end
