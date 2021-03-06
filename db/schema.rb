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

ActiveRecord::Schema.define(:version => 20140420123513) do

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
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "address"
    t.string   "city"
    t.string   "phone",            :null => false
    t.string   "fio",              :null => false
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "email"
    t.string   "metro"
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

  create_table "brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uri"
  end

  create_table "countries", :force => true do |t|
    t.string  "iso",                        :null => false
    t.string  "name",                       :null => false
    t.string  "name_en",                    :null => false
    t.integer "_order",      :default => 0, :null => false
    t.integer "independent", :default => 1, :null => false
  end

  create_table "deliveries", :force => true do |t|
    t.string   "name",                                                      :null => false
    t.decimal  "price",      :precision => 6, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "code"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "name"
    t.decimal  "price"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "size"
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"

  create_table "order_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  create_table "orders", :force => true do |t|
    t.integer  "order_state_id", :default => 1,    :null => false
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.text     "comment"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "can_send_email", :default => true, :null => false
    t.string   "state"
  end

  add_index "orders", ["delivery_id"], :name => "index_orders_on_delivery_id"
  add_index "orders", ["order_state_id"], :name => "index_orders_on_order_state_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "uri",        :null => false
    t.text     "text1"
    t.text     "text2"
    t.text     "text3"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["uri"], :name => "index_pages_on_uri"

  create_table "pictures", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "product_id"
  end

  add_index "pictures", ["product_id"], :name => "index_pictures_on_product_id"

  create_table "product_instances", :force => true do |t|
    t.integer  "product_id"
    t.string   "size"
    t.string   "color"
    t.integer  "count"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_instances", ["product_id"], :name => "index_product_instances_on_product_id"
  add_index "product_instances", ["state_id"], :name => "index_product_instances_on_state_id"

  create_table "products", :force => true do |t|
    t.integer  "section_id",                                                             :null => false
    t.integer  "brand_id",                                                               :null => false
    t.decimal  "price",             :precision => 10, :scale => 2
    t.string   "name",                                                                   :null => false
    t.text     "description"
    t.integer  "discount",                                         :default => 0,        :null => false
    t.integer  "state_id",                                         :default => 2,        :null => false
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.decimal  "purchaise_price",   :precision => 6,  :scale => 2
    t.integer  "country_id"
    t.string   "uri"
    t.integer  "order_items_count",                                :default => 0
    t.string   "color"
    t.string   "matter",                                           :default => "Хлопок", :null => false
    t.integer  "top",                                              :default => 0,        :null => false
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["section_id"], :name => "index_products_on_section_id"
  add_index "products", ["state_id"], :name => "index_products_on_state_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "promo_images", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "promo_id"
  end

  add_index "promo_images", ["promo_id"], :name => "index_promo_images_on_promo_id"

  create_table "promo_items", :force => true do |t|
    t.integer  "promo_id",                  :null => false
    t.integer  "product_id",                :null => false
    t.integer  "count",      :default => 1, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "promos", :force => true do |t|
    t.string   "name",                                                        :null => false
    t.decimal  "price",      :precision => 6, :scale => 2
    t.string   "discount",                                 :default => "0",   :null => false
    t.text     "text",                                                        :null => false
    t.integer  "state_id",                                 :default => 2,     :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.boolean  "top",                                      :default => false, :null => false
    t.string   "link"
  end

  add_index "promos", ["state_id"], :name => "index_promos_on_state_id"
  add_index "promos", ["top"], :name => "index_promos_on_top"

  create_table "sections", :force => true do |t|
    t.string   "name",                                  :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "ancestry"
    t.string   "uri"
    t.integer  "yml_parent_id"
    t.string   "yml_category",  :default => "Футболки", :null => false
    t.text     "description"
    t.integer  "top",           :default => 0,          :null => false
  end

  add_index "sections", ["ancestry"], :name => "index_sections_on_ancestry"

  create_table "site_configurations", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.string   "form_type"
    t.string   "form_collection_command"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "site_configurations", ["key"], :name => "index_site_configurations_on_key", :unique => true

  create_table "states", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "status",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "states", ["status"], :name => "index_states_on_status"

  create_table "users", :force => true do |t|
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
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.string   "phone",                                  :null => false
    t.boolean  "terms_of_service",                       :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
