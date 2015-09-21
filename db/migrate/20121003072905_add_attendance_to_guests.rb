class AddAttendanceToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :attendance, :string, :default => Guest::ATTENDANCES.keys[3]
    add_index :guests, :attendance
  end
end
