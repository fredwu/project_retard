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

ActiveRecord::Schema.define(:version => 0) do

  create_table "colours", :force => true do |t|
    t.string   :name,       :limit => nil
    t.string   :hex,        :limit => nil
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_index "colours", :hex, :name => "index_colours_on_hex"
  add_index "colours", :name, :name => "index_colours_on_name"

  create_table "orders", :force => true do |t|
    t.string   :first_name, :limit => 50
    t.string   :last_name,  :limit => 50
    t.text     :address
    t.string   :postcode,   :limit => 10
    t.string   :state,      :limit => 30
    t.string   :country,    :limit => 50
    t.decimal  :subtotal,                 :precision => 8, :scale => 2
    t.decimal  :use_credit,               :precision => 6, :scale => 2
    t.decimal  :shipping,                 :precision => 6, :scale => 2
    t.decimal  :total,                    :precision => 8, :scale => 2
    t.text     :notes
    t.datetime :shipped_at
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table "products", :force => true do |t|
    t.string   :code,               :limit => 20
    t.string   :name,               :limit => nil
    t.text     :details
    t.text     :highlights
    t.text     :terms
    t.decimal  :rrp,                               :precision => 6, :scale => 2, :default => 0.0
    t.decimal  :price,                             :precision => 6, :scale => 2
    t.integer  :limit_per_customer, :limit => 2,                                 :default => 0
    t.integer  :minimum_purchases,  :limit => 3,                                 :default => 50
    t.boolean  :is_activated,       :limit => nil,                               :default => false
    t.boolean  :is_voucher,         :limit => nil,                               :default => false
    t.datetime :start_at
    t.datetime :end_at
    t.integer  :retailer_id,        :limit => nil
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_index "products", :is_activated, :name => "index_products_on_is_activated"
  add_index "products", :is_voucher, :name => "index_products_on_is_voucher"
  add_index "products", :name, :name => "index_products_on_name"
  add_index "products", [:is_voucher, :is_activated], :name => "index_products_on_is_voucher_and_is_activated"
  add_index "products", [:start_at, :end_at, :is_activated], :name => "index_products_on_start_at_and_end_at_and_is_activated"
  add_index "products", [:start_at, :end_at], :name => "index_products_on_start_at_and_end_at"

  create_table "product_items", :force => true do |t|
    t.integer :stock,                     :default => 0
    t.integer :product_id, :limit => nil
    t.integer :colour_id,  :limit => nil
    t.integer :size_id,    :limit => nil
  end

  add_index "product_items", :colour_id, :name => "index_product_items_on_colour_id"
  add_index "product_items", :product_id, :name => "index_product_items_on_product_id"
  add_index "product_items", :size_id, :name => "index_product_items_on_size_id"
  add_index "product_items", [:product_id, :colour_id, :size_id], :name => "index_product_items_on_product_id_and_colour_id_and_size_id"

  create_table "product_vouchers", :force => true do |t|
    t.string  :code,       :limit => 20
    t.integer :limit,                     :default => 0
    t.integer :product_id, :limit => nil
  end

  add_index "product_vouchers", :product_id, :name => "index_product_vouchers_on_product_id"
  add_index "product_vouchers", [:product_id, :code], :name => "index_product_vouchers_on_product_id_and_code"

  create_table "retailers", :force => true do |t|
    t.string   :name,       :limit => nil
    t.string   :code,       :limit => 10
    t.text     :info
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_index "retailers", :code, :name => "index_retailers_on_code"
  add_index "retailers", :name, :name => "index_retailers_on_name"

  create_table "sizes", :force => true do |t|
    t.string   :name,       :limit => nil
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_index "sizes", :name, :name => "index_sizes_on_name"

  create_table "users", :force => true do |t|
    t.string   :email,                :limit => nil, :default => "",    :null => false
    t.string   :first_name,           :limit => 50
    t.string   :last_name,            :limit => 50
    t.string   :city,                 :limit => 20
    t.string   :encrypted_password,   :limit => 128, :default => "",    :null => false
    t.string   :password_salt,        :limit => nil, :default => "",    :null => false
    t.string   :reset_password_token, :limit => nil
    t.string   :remember_token,       :limit => nil
    t.datetime :remember_created_at
    t.integer  :sign_in_count,        :limit => nil, :default => 0
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip,   :limit => nil
    t.string   :last_sign_in_ip,      :limit => nil
    t.string   :confirmation_token,   :limit => nil
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.boolean  :is_admin,             :limit => nil, :default => false
    t.integer  :retailer_id,          :limit => nil
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_index "users", :confirmation_token, :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", :email, :name => "index_users_on_email", :unique => true
  add_index "users", :reset_password_token, :name => "index_users_on_reset_password_token", :unique => true

end
