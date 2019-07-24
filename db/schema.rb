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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190720090927) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "postal_code",    default: "", null: false
    t.integer  "prefecture_id",               null: false
    t.string   "city",           default: "", null: false
    t.string   "street_address", default: "", null: false
    t.string   "building"
    t.string   "phone_number"
    t.integer  "user_id",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "text",       limit: 65535, null: false
    t.integer  "user_id",                  null: false
    t.integer  "item_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["item_id"], name: "index_comments_on_item_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "creditcards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token",       null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "customer_id", null: false
    t.string   "card_id",     null: false
    t.index ["user_id"], name: "index_creditcards_on_user_id", using: :btree
  end

  create_table "item_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",        default: "", null: false
    t.integer  "item_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["item_id"], name: "index_item_images_on_item_id", using: :btree
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                  default: "", null: false
    t.integer  "price",                                              null: false
    t.text     "text",                    limit: 65535
    t.integer  "condition",                                          null: false
    t.integer  "delivery_charge",                                    null: false
    t.integer  "delivery_method",                                    null: false
    t.integer  "prefecture_id",                                      null: false
    t.integer  "estimated_shipping_date",                            null: false
    t.integer  "category_id"
    t.integer  "brand_id"
    t.integer  "size"
    t.integer  "saler_id"
    t.integer  "buyer_id"
    t.integer  "sales_status",                                       null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["brand_id"], name: "index_items_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["name"], name: "index_items_on_name", using: :btree
    t.index ["price"], name: "index_items_on_price", using: :btree
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "item_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_likes_on_item_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "family_name",                    default: "", null: false
    t.string   "first_name",                     default: "", null: false
    t.string   "family_name_kana",               default: "", null: false
    t.string   "first_name_kana",                default: "", null: false
    t.date     "birthday",                                    null: false
    t.text     "profile_text",     limit: 65535
    t.integer  "user_id",                                     null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "sns_credentials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nickname",                             default: "", null: false
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.text     "avatar_image",           limit: 65535
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "creditcards", "users"
  add_foreign_key "item_images", "items"
  add_foreign_key "likes", "items"
  add_foreign_key "likes", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "sns_credentials", "users"
end