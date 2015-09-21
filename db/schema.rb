# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130219015306) do

  create_table "Events", :force => true do |t|
    t.string   "title"
    t.datetime "event_date"
    t.time     "start_time"
    t.time     "end_time"
    t.decimal  "charity_donation_percent",               :precision => 3, :scale => 2
    t.string   "child_full_name"
    t.string   "host_name"
    t.datetime "child_dob"
    t.text     "page_content_one"
    t.text     "page_content_two"
    t.text     "page_content_three"
    t.text     "page_content_four"
    t.text     "other_page_content"
    t.string   "parental_consent_status",                                              :default => "notConfirmed"
    t.text     "page_customization_hash"
    t.string   "magic_phrase"
    t.integer  "icon_picture_id",                                                      :default => 0
    t.integer  "package_id"
    t.string   "status",                   :limit => 11,                               :default => "in_progress"
    t.integer  "user_id"
    t.integer  "step_id",                                                              :default => 1
    t.string   "state",                    :limit => 11,                               :default => "not_ready"
    t.boolean  "publicly_viewable",                                                    :default => false
    t.datetime "created_at",                                                                                       :null => false
    t.datetime "updated_at",                                                                                       :null => false
    t.string   "child_pronoun"
    t.string   "location_name"
    t.string   "location_address"
    t.integer  "event_sequence",                                                       :default => 1
    t.string   "slug"
    t.boolean  "gift_fund_locked",                                                     :default => true
    t.boolean  "donation_fund_locked",                                                 :default => true
    t.boolean  "contributions_locked",                                                 :default => false
    t.date     "rsvp_by"
    t.string   "theme_code",                                                           :default => "default"
    t.datetime "deleted_at"
    t.string   "parents_invited",                                                      :default => "optional"
    t.string   "invite_option"
  end

  add_index "Events", ["child_dob"], :name => "index_events_on_child_dob"
  add_index "Events", ["child_full_name"], :name => "index_events_on_child_full_name"
  add_index "Events", ["event_date"], :name => "index_events_on_event_date"
  add_index "Events", ["location_name"], :name => "index_events_on_location_name"
  add_index "Events", ["slug"], :name => "index_events_on_slug"
  add_index "Events", ["state"], :name => "index_events_on_state"
  add_index "Events", ["status"], :name => "index_events_on_status"
  add_index "Events", ["step_id"], :name => "index_events_on_step_id"
  add_index "Events", ["theme_code"], :name => "index_events_on_theme_code"
  add_index "Events", ["title"], :name => "index_events_on_title"

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

  create_table "addresses", :force => true do |t|
    t.integer "user_id",                             :null => false
    t.string  "first_name"
    t.string  "last_name"
    t.string  "company_name"
    t.string  "address_1"
    t.string  "address_2"
    t.string  "city"
    t.integer "state_id"
    t.string  "postal_code"
    t.string  "atype",        :default => "mailing"
  end

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

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "carts", :force => true do |t|
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "carts", ["event_id"], :name => "index_carts_on_event_id"
  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "carts_archive", :force => true do |t|
    t.integer  "event_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charities", :force => true do |t|
    t.string   "name"
    t.string   "name_alias"
    t.text     "description"
    t.string   "city"
    t.string   "region"
    t.string   "website_url"
    t.string   "lookup_charity_code_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "featured",               :default => false
    t.boolean  "top_recommended",        :default => false
    t.string   "syw_altkey"
    t.string   "vendor1_altkey"
    t.string   "vendor2_altkey"
    t.string   "temp_icon_filename"
    t.datetime "deleted_at"
  end

  add_index "charities", ["featured"], :name => "index_charities_on_featured"
  add_index "charities", ["lookup_charity_code_id"], :name => "index_charities_on_ntee_code"
  add_index "charities", ["name_alias"], :name => "index_charities_on_name_alias"
  add_index "charities", ["syw_altkey"], :name => "index_charities_syw_altkey_uq", :unique => true
  add_index "charities", ["syw_altkey"], :name => "index_charities_syw_charity_id_uq", :unique => true
  add_index "charities", ["top_recommended"], :name => "index_charities_on_top_recommended"
  add_index "charities", ["vendor1_altkey"], :name => "index_charities_vendor1_altkey_uq", :unique => true
  add_index "charities", ["vendor2_altkey"], :name => "index_charities_vendor2_altkey_uq", :unique => true

  create_table "charities_events", :force => true do |t|
    t.integer "event_id"
    t.integer "charity_id"
  end

  create_table "children", :force => true do |t|
    t.string   "name"
    t.date     "dob"
    t.integer  "guest_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "children", ["event_id"], :name => "index_children_on_event_id"
  add_index "children", ["guest_id"], :name => "index_children_on_guest_id"

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "email"
    t.text     "content"
    t.boolean  "visible"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "guest_id"
    t.datetime "deleted_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["guest_id"], :name => "index_comments_on_guest_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contributions", :force => true do |t|
    t.decimal  "amount",              :precision => 10, :scale => 2, :default => 0.0
    t.boolean  "anonymous",                                          :default => false
    t.integer  "charity_id"
    t.integer  "guest_id"
    t.integer  "event_id"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.datetime "deleted_at"
    t.boolean  "pay_transaction_fee",                                :default => false
  end

  add_index "contributions", ["charity_id"], :name => "index_contributions_on_charity_id"
  add_index "contributions", ["event_id"], :name => "index_contributions_on_event_id"
  add_index "contributions", ["guest_id"], :name => "index_contributions_on_guest_id"

  create_table "event_activity_logs", :force => true do |t|
    t.text     "message"
    t.boolean  "is_internal", :default => true
    t.integer  "event_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "type_of"
  end

  add_index "event_activity_logs", ["created_at"], :name => "index_event_activity_logs_on_created_at"
  add_index "event_activity_logs", ["event_id"], :name => "index_event_activity_logs_on_event_id"
  add_index "event_activity_logs", ["is_internal"], :name => "index_event_activity_logs_on_is_internal"
  add_index "event_activity_logs", ["type_of"], :name => "index_event_activity_logs_on_type_of"

  create_table "event_transaction_logs", :force => true do |t|
    t.integer  "event_transaction_log_category_id"
    t.string   "description"
    t.string   "memo"
    t.decimal  "event_fund",                        :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "gift_fund",                         :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "donation_fund",                     :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "syw_fund",                          :precision => 10, :scale => 2, :default => 0.0
    t.integer  "contribution_id"
    t.integer  "event_id"
    t.integer  "payment_id"
    t.integer  "charity_id"
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
  end

  create_table "events_log", :force => true do |t|
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "title"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guests", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "email"
    t.integer  "lookup_guests_status_id", :default => 1
    t.string   "guest_access_token"
    t.boolean  "hidden",                  :default => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "attendance",              :default => "no_reply"
    t.string   "message"
    t.integer  "braintree_customer_id"
    t.datetime "deleted_at"
  end

  add_index "guests", ["attendance"], :name => "index_guests_on_attendance"
  add_index "guests", ["email"], :name => "index_guests_on_email"
  add_index "guests", ["hidden"], :name => "index_guests_on_hidden"

  create_table "help_messages", :force => true do |t|
    t.string   "code"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "help_messages", ["code"], :name => "index_help_messages_on_code"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "cost",             :precision => 8, :scale => 2
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "sort_order",                                     :default => 1,     :null => false
    t.boolean  "taxable",                                        :default => true,  :null => false
    t.boolean  "is_package_proxy",                               :default => false, :null => false
    t.boolean  "is_visible",                                     :default => true,  :null => false
    t.datetime "deleted_at"
  end

  create_table "items_packages", :id => false, :force => true do |t|
    t.integer "package_id"
    t.integer "item_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "quantity",                                 :default => 1
    t.decimal  "cost",       :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.datetime "deleted_at"
  end

  create_table "lookup_charity_codes", :force => true do |t|
    t.string "ntee_code"
    t.string "title"
  end

  create_table "lookup_event_sequences", :primary_key => "sequence", :force => true do |t|
    t.string   "code"
    t.text     "friendly_text"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "lookup_event_sequences", ["code"], :name => "index_lookup_event_states_on_code"

  create_table "lookup_guests_statuses", :force => true do |t|
    t.string "status_code",   :default => "inviteNotSent"
    t.string "friendly_text"
  end

  add_index "lookup_guests_statuses", ["status_code"], :name => "index_lookup_guests_statuses_on_status_code"

  create_table "lookup_order_status", :id => false, :force => true do |t|
    t.string "order_status_code",          :null => false
    t.string "order_status_friendly_text", :null => false
  end

  create_table "lookup_shipping_methods", :id => false, :force => true do |t|
    t.string "shipping_method_code",          :null => false
    t.string "shipping_method_friendly_text", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                                                  :null => false
    t.integer  "event_id",                                                                 :null => false
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "shipping_method_code",                                 :default => 0,      :null => false
    t.string   "order_status_code",                                    :default => "cart", :null => false
    t.decimal  "tax_total_cost",         :precision => 8, :scale => 2, :default => 0.0,    :null => false
    t.decimal  "shipping_total_cost",    :precision => 8, :scale => 2, :default => 0.0,    :null => false
    t.decimal  "adjustments_total_cost", :precision => 8, :scale => 2, :default => 0.0,    :null => false
    t.decimal  "total_cost",             :precision => 8, :scale => 2, :default => 0.0,    :null => false
    t.text     "customer_notes"
    t.text     "internal_notes"
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
    t.datetime "deleted_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "cost",          :precision => 8, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "proxy_item_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "teaser"
    t.text     "text"
    t.string   "slug"
    t.integer  "order",        :limit => 3, :default => 0
    t.boolean  "show_in_menu",              :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "pages", ["order"], :name => "index_pages_on_order"
  add_index "pages", ["show_in_menu"], :name => "index_pages_on_show_in_menu"
  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "payments", :force => true do |t|
    t.string   "order_id"
    t.decimal  "amount",              :precision => 8, :scale => 2, :default => 0.0,                   :null => false
    t.string   "payment_method",                                    :default => "braintree"
    t.string   "last_four_digits"
    t.string   "processing_response",                               :default => "awaiting processing"
    t.string   "status"
    t.integer  "contribution_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                           :null => false
    t.datetime "updated_at",                                                                           :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.integer  "sort_order"
    t.string   "layout_section"
    t.integer  "layout_slot"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "pictures", ["sort_order"], :name => "index_pictures_on_sort_order"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "tags"
    t.text     "content"
    t.integer  "posts_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "author"
    t.datetime "deleted_at"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true

  create_table "posts_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.integer  "sequence",    :limit => 2, :default => 0
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "posts_categories", ["sequence"], :name => "index_posts_categories_on_sequence"
  add_index "posts_categories", ["slug"], :name => "index_posts_categories_on_slug", :unique => true

  create_table "shipments", :force => true do |t|
    t.integer  "order_id",                 :null => false
    t.integer  "shipping_method_code"
    t.string   "shipment_tracking_number"
    t.string   "special_instructions"
    t.datetime "shipment_date"
    t.text     "internal_notes"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "states", :force => true do |t|
    t.string "name", :null => false
    t.string "abbr", :null => false
  end

  create_table "steps", :force => true do |t|
    t.string   "title"
    t.integer  "order",                :limit => 2, :default => 0
    t.string   "slug"
    t.boolean  "locked_on_completion",              :default => false
    t.boolean  "must_complete",                     :default => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "steps", ["order"], :name => "index_steps_on_order"

  create_table "subscribers", :force => true do |t|
    t.text     "full_name"
    t.text     "email"
    t.text     "comment"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "displayme",  :default => true
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "themes", :primary_key => "code", :force => true do |t|
    t.string   "friendly_name"
    t.boolean  "is_premium",                                  :default => false
    t.decimal  "cost",          :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "full_name",                                    :null => false
    t.string   "user_name"
    t.string   "cached_slug"
    t.string   "language",               :default => "en"
    t.boolean  "is_under_age",           :default => false
    t.boolean  "terms_of_use",           :default => false
    t.boolean  "subscriber_opt_in",      :default => false
    t.string   "role",                   :default => "tester"
    t.integer  "braintree_customer_id"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["is_under_age"], :name => "index_users_on_is_under_age"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

end
