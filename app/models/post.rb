class Post < ActiveRecord::Base
  extend FriendlyId
  self.per_page = 5
  friendly_id :title, use: :slugged
  acts_as_paranoid
  acts_as_commentable
  acts_as_taggable
  default_scope order(:created_at).reverse_order
  scope :by_updated, order(:updated_at).reverse_order
  validates :title, :content, :author, :slug, :posts_category, :presence => true
  attr_accessible :title, :content, :author, :slug, :posts_category_id, :posts_category, :tag_list
  belongs_to :posts_category, :inverse_of => :posts
 end
