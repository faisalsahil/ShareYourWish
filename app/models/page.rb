class Page < ActiveRecord::Base
  validates :title, :text, :slug, :order, :presence => true
  validates :title, :length => { :in => 2..255 }
  validates_uniqueness_of :slug
  validates_numericality_of :order, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999
  attr_accessible :title, :teaser, :text, :slug, :order, :show_in_menu
end
