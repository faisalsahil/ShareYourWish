class AddTimestampsToNewTables < ActiveRecord::Migration
  def change
       add_column(:Cart, :created_at, :datetime)
       add_column(:Cart, :updated_at, :datetime)
       
       add_column(:CartArchive, :created_at, :datetime)
       add_column(:CartArchive, :updated_at, :datetime)
       
       add_column(:Charities, :created_at, :datetime)
       add_column(:Charities, :updated_at, :datetime)
       
       add_column(:Comments, :created_at, :datetime)
       add_column(:Comments, :updated_at, :datetime)
       
       add_column(:Gifts, :created_at, :datetime)
       add_column(:Gifts, :updated_at, :datetime)
       
       add_column(:Events, :created_at, :datetime)
       add_column(:Events, :updated_at, :datetime)
       
       add_column(:EventsLog, :created_at, :datetime)
       add_column(:EventsLog, :updated_at, :datetime)
       
       add_column(:Guests, :created_at, :datetime)
       add_column(:Guests, :updated_at, :datetime)
       
       add_column(:Items, :created_at, :datetime)
       add_column(:Items, :updated_at, :datetime)
       
       add_column(:Packages, :created_at, :datetime)
       add_column(:Packages, :updated_at, :datetime)
       
        add_column(:Pictures, :created_at, :datetime)
        add_column(:Pictures, :updated_at, :datetime)
        
         add_column(:Posts, :created_at, :datetime)
         add_column(:Posts, :updated_at, :datetime)

  end
end
