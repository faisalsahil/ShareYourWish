class ChangeContributionsCcCvv < ActiveRecord::Migration
 def self.up
    change_table :contributions do |t|
      t.change :cc_cvv, :string
    end
  end
  def self.down
    change_table :contributions do |t|
      t.change :cc_cvv, :integer
    end
  end
end
