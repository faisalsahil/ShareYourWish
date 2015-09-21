class CorrectRsvPdata < ActiveRecord::Migration
  def up
     execute "UPDATE events SET rsvp_by = DATE_ADD(event_date, INTERVAL -11 DAY) "
  end

  def down
  end
end
