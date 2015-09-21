class SupportMultipleHostChildren < ActiveRecord::Migration
  def up
     rename_column :events, :child_gender, :child_pronoun
     execute 'update events set child_pronoun = lower(child_pronoun)'
  end

  def down
     rename_column :events, :child_pronoun, :child_gender
  end
end