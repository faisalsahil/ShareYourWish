class InitialBulkShemaCreation < ActiveRecord::Migration
  def up
     create_table "Events" do |t|
       t.integer  "user_id"
       t.string   "title"
       t.datetime "event_date"
       t.datetime "start_time"
       t.datetime "end_time"
       t.decimal  "charity_donation_percent", :precision => 3, :scale => 2
       t.string   "child_full_name"
       t.datetime "child_dob"
       t.text     "page_content_one"
       t.text     "page_content_two"
       t.text     "page_content_three"
       t.text     "page_content_four"
       t.text     "other_page_content"
       t.string   "parental_consent_status"
       t.string   "page_alias"
       t.text     "page_customization_hash"
       t.string   "magic_phrase"
       t.integer  "icon_picture_id"
       t.integer  "package_id"
   end
   
   create_table "EventsGuests" do |t|
      t.integer	"event_id"
      t.integer	"user_id"
      t.string	   "full_name"
      t.string	   "email"
      t.integer	"status_id"
      t.string	   "guest_access_token"
      t.boolean	"hidden"
    end
      
   create_table "lookup_EventsGuests_Status" do |t|
      t.string	"status_code"
      t.string	"friendly_text"
    end

   create_table "EventsDonations" do |t|
      t.integer	"event_id"
      t.integer	"user_id"
      t.string	   "currency"
      t.decimal	"amount", :precision => 8, :scale => 2
      t.datetime	"donation_date"
      t.string	   "transaction_status"
    end

   create_table "Charities" do |t|
      t.string	   "name"
      t.string	   "alias"
      t.string	   "description"
      t.string	   "city"
      t.string	   "region"
      t.string	   "url"
      t.string	   "ntee_code"
      t.integer	"icon_picture_id"
    end

   create_table "EventsCharities" do |t|
      t.integer	"event_id"
      t.integer	"charity_id"
    end

   create_table "FeaturedCharities" do |t|
      t.integer	"charity_id"
      t.datetime	"start_date"
      t.datetime	"end_date"
      t.integer	"weight"
    end

   create_table "lookup_CharityCodes" do |t|
      t.string	   "ntee_code"
      t.string	   "title"
    end

   create_table "Pictures" do |t|
      t.string	   "imageable_type"
      t.integer	"imageable_id"
      t.integer	"sort_order"
      t.string	   "layout_section"
      t.integer	"layout_slot"
      t.string	   "image_file_name"
      t.string	   "image_content_type"
      t.integer	"image_file_size"
      t.datetime	"image_updated_at"
    end

   create_table "Comments" do |t|
      t.string	   "commentable_type"
      t.integer	"commentable_id"
      t.integer	"user_id"
      t.string	   "full_name"
      t.string	   "email"
      t.text	   "content"
      t.boolean	"visible"
    end

   create_table "Packages" do |t|
      t.string	   "name"
      t.text	   "description"
      t.decimal	"cost"
    end

   create_table "Items" do |t|
      t.string	   "name"
      t.text	   "description"
      t.decimal	"cost", :precision => 8, :scale => 2
    end

   create_table "PackagesItems" do |t|
      t.integer	"package_id"
      t.integer	"item_id"
      t.integer	"default_item_qty"
    end

   create_table "EventsLog" do |t|
      t.integer	"event_id"
      t.text	   "content"
    end

   create_table "Cart" do |t|
      t.integer	"event_id"
      t.integer	"item_id"
      t.integer	"quantity"
    end

   create_table "CartArchive" do |t|
       t.integer	"event_id"
       t.integer	"item_id"
       t.integer	"quantity"
    end
  end

  def down
     drop_table "Events"
     drop_table "EventsGuests"
     drop_table "lookup_EventsGuests_Status"
     drop_table "EventsDonations"
     drop_table "Charities"
     drop_table "EventsCharities"
     drop_table "FeaturedCharities"
     drop_table "lookup_CharityCodes"
     drop_table "Pictures"
     drop_table "Comments"
     drop_table "Packages"
     drop_table "Items"
     drop_table "PackagesItems"
     drop_table "EventsLog"
     drop_table "Cart"
     drop_table "CartArchive"
  end
end
