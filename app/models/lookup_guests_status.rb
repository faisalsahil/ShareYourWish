class LookupGuestsStatus < ActiveRecord::Base
  has_many :guests, :inverse_of => :lookup_guests_status

  def hasMadeDonation?
    self.status_code == 'hasMadeDonation'
  end
  
  def hasRejectedDonation? 
    self.status_code == 'hasRejectedDonation'
  end

  def next
    LookupGuestsStatus.where('id > ?', self.id).first
  end
end