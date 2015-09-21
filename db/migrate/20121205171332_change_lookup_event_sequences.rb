class ChangeLookupEventSequences < ActiveRecord::Migration
  def up
    LookupEventSequence.update(6, :code => :event_complete, :friendly_text => 'Event Complete')
  end

  def down
    LookupEventSequence.update(6, :code => :finish_event, :friendly_text => 'Finish Event')
  end
end
