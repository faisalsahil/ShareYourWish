class EvenMoreSyncs < ActiveRecord::Migration
  def up

     drop_table :events
     create_table "events", :force => true do |t|
       t.string   "title"
       t.date     "event_date"
       t.time     "start_time"
       t.time     "end_time"
       t.decimal  "charity_donation_percent",               :precision => 3, :scale => 2
       t.string   "child_full_name"
       t.date     "child_dob"
       t.text     "page_content_one"
       t.text     "page_content_two"
       t.text     "page_content_three"
       t.text     "page_content_four"
       t.text     "other_page_content"
       t.string   "parental_consent_status",                                              :default => "notConfirmed"
       t.string   "page_alias"
       t.text     "page_customization_hash"
       t.string   "magic_phrase"
       t.integer  "icon_picture_id",                                                      :default => 0
       t.integer  "package_id"
       t.string   "status",                   :limit => 11,                               :default => "in_progress"
       t.integer  "user_id"
       t.integer  "step_id",                                                              :default => 1
       t.string   "state",                    :limit => 11,                               :default => "not_ready"
       t.datetime "created_at",                                                                                       :null => false
       t.datetime "updated_at",                                                                                       :null => false
     end
     
     add_index "events", ["child_dob"], :name => "index_events_on_child_dob"
     add_index "events", ["event_date"], :name => "index_events_on_event_date"
     add_index "events", ["state"], :name => "index_events_on_state"
     add_index "events", ["status"], :name => "index_events_on_status"
     add_index "events", ["step_id"], :name => "index_events_on_step_id"
     
     drop_table :guests
     create_table "guests", :force => true do |t|
       t.integer  "event_id"
       t.integer  "user_id"
       t.string   "full_name"
       t.string   "email"
       t.integer  "lookup_guests_status_id", :default => 1
       t.integer  "guest_access_token"
       t.boolean  "hidden",                  :default => false
       t.datetime "created_at",                                 :null => false
       t.datetime "updated_at",                                 :null => false
     end

     add_index "guests", ["hidden"], :name => "index_guests_on_hidden"
     
     
  end

  def down
  end
end
