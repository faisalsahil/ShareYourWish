class ModifyCharityDescriptionDatatype < ActiveRecord::Migration
  def up
     change_column :charities, :description, :text
  end

  def down
  end
end
