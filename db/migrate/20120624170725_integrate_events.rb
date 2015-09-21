class IntegrateEvents < ActiveRecord::Migration
  def up
     
     create_table "active_admin_comments", :force => true do |t|
       t.string   "resource_id",   :null => false
       t.string   "resource_type", :null => false
       t.integer  "author_id"
       t.string   "author_type"
       t.text     "body"
       t.datetime "created_at",    :null => false
       t.datetime "updated_at",    :null => false
       t.string   "namespace"
     end

     add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
     add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
     add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

     create_table "admin_users", :force => true do |t|
       t.string   "email",                  :default => "", :null => false
       t.string   "encrypted_password",     :default => "", :null => false
       t.string   "reset_password_token"
       t.datetime "reset_password_sent_at"
       t.datetime "remember_created_at"
       t.integer  "sign_in_count",          :default => 0
       t.datetime "current_sign_in_at"
       t.datetime "last_sign_in_at"
       t.string   "current_sign_in_ip"
       t.string   "last_sign_in_ip"
       t.datetime "created_at",                             :null => false
       t.datetime "updated_at",                             :null => false
     end

     add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
     add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true


     
  end

  def down
  end
end
