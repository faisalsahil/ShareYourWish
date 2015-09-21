class RecreateLookupEventStates < ActiveRecord::Migration
  def up
     # make state (to be sequence) 1-based instead of 0-based, and fix sequence 2 should be 'invitationS' plural
     
     # At the time this was originally run, the model was LookupEventState
     # so cancel this and create a later migration
     
     #LookupEventState.delete_all
     #LookupEventState.create(:code => :setup_event, :sequence => 1, :friendly_text => 'Setup Event')
     #LookupEventState.create(:code => :send_invitations, :sequence => 2, :friendly_text => 'Send Invitations')
     #LookupEventState.create(:code => :release_gift_fund, :sequence => 3, :friendly_text => 'Release Gift Fund')
     #LookupEventState.create(:code => :day_of_event, :sequence => 4, :friendly_text => 'Day of Event')
     #LookupEventState.create(:code => :release_donation_fund, :sequence => 5, :friendly_text => 'Release Donation Fund')
     #LookupEventState.create(:code => :finish_event, :sequence => 6, :friendly_text => 'Finish Event')
     
  end

  def down
  end
end
