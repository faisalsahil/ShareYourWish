class PostsCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessible :description, :name, :sequence, :slug
  validates :name, :sequence, :presence => true
  validates_numericality_of :sequence, :only_integer => true
  has_many :posts, :inverse_of => :posts_category
end
