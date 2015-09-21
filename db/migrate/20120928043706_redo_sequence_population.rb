class RedoSequencePopulation < ActiveRecord::Migration
  def up
     LookupEventSequence.delete_all
     LookupEventSequence.create(:code => :setup_event, :sequence => 1, :friendly_text => 'Setup Event')
     LookupEventSequence.create(:code => :send_invitations, :sequence => 2, :friendly_text => 'Send Invitations')
     LookupEventSequence.create(:code => :release_gift_fund, :sequence => 3, :friendly_text => 'Release Gift Fund')
     LookupEventSequence.create(:code => :day_of_event, :sequence => 4, :friendly_text => 'Day of Event')
     LookupEventSequence.create(:code => :release_donation_fund, :sequence => 5, :friendly_text => 'Release Donation Fund')
     LookupEventSequence.create(:code => :finish_event, :sequence => 6, :friendly_text => 'Finish Event')
     
  end

  def down
  end
end
