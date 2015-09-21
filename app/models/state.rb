class State < ActiveRecord::Base
  has_many :addresses
  validates :name, :abbr, :presence => true
end
