class User < ActiveRecord::Base
  include Extensions::BraintreeSyw

  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :validatable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  ROLES = %w[visitor banned user tester admin]

  has_many :events, :inverse_of => :user
  has_many :pictures, :as => :imageable
  has_many :guests, :inverse_of => :user
  has_many :comments, :inverse_of => :user
  has_many :orders
  has_many :carts
  has_many :addresses
  has_one :mailing_address, :class_name => 'Address', :conditions => {:atype => :mailing}, :validate => true
  has_many :authentications
  has_many :feedbacks, :inverse_of => :user

  validates :full_name, :presence => { :message => "is required" }

  validates :email, :presence => true, :uniqueness => true,
             :format => {
                :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                :message => "is not formatted properly"
                }, :on => :create

  validates :role, :presence => true, :inclusion => { :in => ROLES }
  validates :terms_of_use, :acceptance => {:accept => true}
  validates :password, :presence => true, :on => :create, :unless => :login_with_social?
  validates :password, :confirmation => true, :length => {:in => 6..20}, :allow_blank => true, :unless => :login_with_social?

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me, :user_name, :role
  attr_accessible :is_under_age, :language, :terms_of_use, :subscriber_opt_in, :braintree_customer_id
  attr_accessible :login_with_social, :authentications_attributes, :address, :mailing_address_attributes
  attr_accessor :login_with_social
  accepts_nested_attributes_for :authentications, :mailing_address
 # attr_protected :role

  after_create :welcome!

  def welcome!
    UserMailer.welcome(self).deliver
  end

  def event_updated!(event)
     # Send an email to user whenever their Event has entered a new sequence step
    return false unless event.lookup_event_sequence
    UserMailer.send(event.lookup_event_sequence.code, self, event).deliver if event.event_sequence > 2
  end

  def apply_omniauth(omniauth)
    # store user info locally and build an authentication record
    self.email = omniauth['info']['email'] if email.blank?
    self.full_name = omniauth['info']['name'] if full_name.blank?
    self.password = self.password_confirmation = Devise.friendly_token[0,20] if self.encrypted_password.blank? # put in a stub password
    self.login_with_social = true
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'] )
  end

  def password_required?
    # override ActiveRecord validation helper method to allow blank PW if there is no authentication
    # NOTE: I don't think I like this, probably will drop
    (authentications.empty? || !password.blank?) && super
  end

  def login_with_social?
    authentications.present? || login_with_social.present?
  end

  def login_with?(provider = :facebook)
    result = false
    authentications.each do |authentication|
      result = true if authentication.provider.to_s.eql?(provider.to_s)
    end
    result
  end

  def facebook_authentication
    authentications.where(:provider => :facebook).first
  end

  def has_facebook_account?
    facebook_authentication.present?
  end

  def facebook_login
    return nil unless has_facebook_account?
    facebook_authentication.uid
  end

  def google_authentication
    authentications.where(:provider => :google_oauth2).first
  end

  def has_google_account?
    google_authentication.present?
  end

  def google_login
    return nil unless has_google_account?
    google_authentication.uid
  end

  def twitter_authentication
    authentications.where(:provider => :twitter).first
  end

  def has_twitter_account?
    twitter_authentication.present?
  end

  def twitter_login
    return nil unless has_twitter_account?
    twitter_authentication.uid
  end

  def can_delete_comment? comment, event = nil
    return false unless event
    return false unless event.user_id
    return false unless self.persisted?
    return false unless comment.commentable_type == 'Event'
    return false unless comment.commentable_id == event.id
    event.user_id == self.id
  end

  def is_admin?
    self.role == "admin"
  end

  def is?(role)
    self.role.to_s == role.to_s
  end

  def user_event_for_menu
     r = self.events.where(:status=>'published').order("created_at DESC")
     r.empty? ? nil : r.first
  end
end

