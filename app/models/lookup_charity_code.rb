class LookupCharityCode < ActiveRecord::Base
  has_many :charities, :inverse_of => :lookup_charity_code

  def self.not_empty
    self.joins(:charities).group(:id)
  end
end
