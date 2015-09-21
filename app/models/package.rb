class Package < ActiveRecord::Base
  has_one :picture, :as => :imageable
  has_and_belongs_to_many :items
  has_many :events, :inverse_of => :package
  
  def self.free
    self.find_by_cost(0);
  end
end
