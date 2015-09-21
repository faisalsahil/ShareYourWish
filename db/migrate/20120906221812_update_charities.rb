class UpdateCharities < ActiveRecord::Migration
  def up
     add_column :charities, :temp_icon_filename, :string
     Charity.reset_column_information
     Charity.delete_all
     # the 'LOCAL' clause is needed in DEV but it is not accepted on PROD (staging) server...why?
     cmd = "LOAD DATA INFILE '" + Rails.root.join('app','assets','temp','charity_seed','tier_two_charity_list.txt').to_s + "' INTO TABLE charities FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES (name, description, region, lookup_charity_code_id, featured, top_recommended, syw_altkey, temp_icon_filename);"
     execute cmd
     @charities = Charity.find(:all)
     @charities.each do |c|
        Picture.create(imageable_type: :charity, imageable_id: c.id, sort_order: 1, layout_section: "layout1", layout_slot: 1, image: File.new(Rails.root + 'app/assets/temp/charity_seed/'+c.temp_icon_filename))
     end
     
  end

  def down
  end
end
