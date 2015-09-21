class Comment < ActiveRecord::Base
  acts_as_paranoid
  include ActsAsCommentable::Comment
  self.per_page = 6
  belongs_to :commentable, :polymorphic => true

  default_scope order(:created_at).reverse_order

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :guest, :inverse_of => :user
  belongs_to :user, :inverse_of => :comments

  validates :guest, :presence => true, :if => :comment_for_event?
  validates :full_name, :presence => true, :if => :comment_for_post?
  validates :content, :presence => { :message => " of your comment is missing" }
                          
  validates :email, :allow_blank => true, :on => :create, :if => :comment_for_post?,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is not formatted properly"}
            
  after_create :log_comment, :if => :comment_for_event?
  attr_accessible :guest, :guest_id, :full_name, :content, :email, :commentable_type, :commentable_id

  def log_comment
    EventActivityLog::create_comment(self)
  end

  def comment_for_event?
    self.commentable.is_a? Event
  end

  def comment_for_post?
    self.commentable.is_a? Post
  end

  def fullname
    if self.user 
      self.user.full_name 
    elsif self.guest && !self.guest.anonymous? 
      self.guest.full_name
    elsif self.full_name
      self.full_name
    else
      "Anonymous"
    end
  end
    
end
