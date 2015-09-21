class CreateAuthenticationsAndSessions < ActiveRecord::Migration
  def up
     create_table "authentications", :force => true do |t|
       t.integer  "user_id"
       t.string   "provider"
       t.string   "uid"
       t.datetime "created_at"
       t.datetime "updated_at"
       t.string   "token"
     end
  end

  def down
     drop_table "authentications"
  end
end


