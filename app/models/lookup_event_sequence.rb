class LookupEventSequence < ActiveRecord::Base
  self.primary_key = :sequence
  has_many :events, :foreign_key => :event_sequence
  validates :code, :sequence, :friendly_text, :presence => true
  #validates :sequence, :inclusion => { :in => [0,1,2,3,4,5] }
  attr_accessible :code, :sequence, :friendly_text

end
