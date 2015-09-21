class AddThemesTestData < ActiveRecord::Migration
  def up
     Theme.create([
     {:code => :default, :is_premium => false, :cost => 0.0, :friendly_name => 'Default'},
     {:code => :first, :is_premium => false, :cost => 0.0, :friendly_name => 'First'},
     {:code => :second, :is_premium => false, :cost => 0.0, :friendly_name => 'Second'},
     {:code => :third, :is_premium => false, :cost => 0.0, :friendly_name => 'Third'},
     {:code => :fourth, :is_premium => false, :cost => 0.0, :friendly_name => 'Fourth'},
     {:code => :fifth, :is_premium => true, :cost => 10.0, :friendly_name => 'Fifth'}
     ]) unless Theme.count > 0
  end

  def down
  end
end
