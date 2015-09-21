class ChangeContributionsAmount < ActiveRecord::Migration
 def self.up
    change_table :contributions do |t|
      t.change :amount, :decimal, :precision => 10, :scale => 2, :default => 0
    end
  end
  def self.down
    change_table :contributions do |t|
      t.change :amount, :integer, :default => 0
    end
  end
end
