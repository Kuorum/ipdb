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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151201201338) do

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "region",     limit: 255
    t.string   "source",     limit: 255
    t.boolean  "scraped",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "scraper",    limit: 255
  end

  create_table "data", force: :cascade do |t|
    t.string   "sourceWebsite",                 limit: 255
    t.string   "name",                          limit: 255
    t.string   "picture",                       limit: 255
    t.string   "politicalParty",                limit: 255
    t.string   "politicalPartyImage",           limit: 255
    t.string   "verified",                      limit: 255
    t.integer  "likes",                         limit: 4
    t.integer  "followers",                     limit: 4
    t.string   "email",                         limit: 255
    t.string   "twitter",                       limit: 255
    t.string   "facebook",                      limit: 255
    t.string   "linkedin",                      limit: 255
    t.string   "googlePlus",                    limit: 255
    t.string   "instagram",                     limit: 255
    t.string   "blog",                          limit: 255
    t.string   "youtubeChannel",                limit: 255
    t.string   "premium",                       limit: 255
    t.text     "bio",                           limit: 65535
    t.text     "quote1",                        limit: 65535
    t.text     "quote2",                        limit: 65535
    t.string   "sourceActivity",                limit: 255
    t.text     "lastActivity1",                 limit: 65535
    t.text     "lastActivity2",                 limit: 65535
    t.text     "lastActivity3",                 limit: 65535
    t.text     "lastActivity4",                 limit: 65535
    t.decimal  "ideology1",                                        precision: 64, scale: 12
    t.decimal  "ideology2",                                        precision: 64, scale: 12
    t.decimal  "ideology3",                                        precision: 64, scale: 12
    t.decimal  "ideology4",                                        precision: 64, scale: 12
    t.decimal  "ideology5",                                        precision: 64, scale: 12
    t.integer  "following",                     limit: 4
    t.integer  "openProjects",                  limit: 4
    t.integer  "closedProjects",                limit: 4
    t.integer  "proposals",                     limit: 4
    t.integer  "debates",                       limit: 4
    t.integer  "sponsorships",                  limit: 4
    t.integer  "victories",                     limit: 4
    t.string   "dateOfBirth",                   limit: 255
    t.string   "placeOfBirth",                  limit: 255
    t.text     "institutionalAddress",          limit: 65535
    t.string   "institutionalTelephone",        limit: 255
    t.string   "institutionalFax",              limit: 255
    t.string   "institutionalMobilePhone",      limit: 255
    t.string   "electoralAddress",              limit: 255
    t.string   "electoralTelephone",            limit: 255
    t.string   "electoralFax",                  limit: 255
    t.string   "electoralMobile",               limit: 255
    t.string   "phone",                         limit: 255
    t.string   "assistants",                    limit: 255
    t.string   "completeName",                  limit: 255
    t.string   "position",                      limit: 255
    t.string   "region",                        limit: 255
    t.string   "institution",                   limit: 255
    t.string   "constituency",                  limit: 255
    t.string   "studies",                       limit: 255
    t.string   "university",                    limit: 255
    t.string   "profession",                    limit: 255
    t.string   "cvLink",                        limit: 255
    t.string   "declarationLink",               limit: 255
    t.string   "officialWebsite",               limit: 255
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
    t.text     "politicalExperience",           limit: 65535
    t.text     "causes",                        limit: 65535
    t.string   "region_code_alliance",          limit: 255
    t.string   "region_code_nation",            limit: 255
    t.string   "region_code_state",             limit: 255
    t.string   "region_code_county",            limit: 255
    t.string   "region_code_city",              limit: 255
    t.string   "constituency_code_alliance",    limit: 255
    t.string   "constituency_code_nation",      limit: 255
    t.string   "constituency_code_state",       limit: 255
    t.string   "constituency_code_county",      limit: 255
    t.string   "constituency_code_city",        limit: 255
    t.decimal  "political_leaning_index",                          precision: 64, scale: 12
    t.string   "cause1",                        limit: 255
    t.string   "cause2",                        limit: 255
    t.string   "cause3",                        limit: 255
    t.string   "cause4",                        limit: 255
    t.string   "cause5",                        limit: 255
    t.string   "known_for1",                    limit: 255
    t.string   "known_for2",                    limit: 255
    t.string   "known_for3",                    limit: 255
    t.string   "known_for4",                    limit: 255
    t.string   "known_for5",                    limit: 255
    t.string   "known_for_link1",               limit: 255
    t.string   "known_for_link2",               limit: 255
    t.string   "known_for_link3",               limit: 255
    t.string   "known_for_link4",               limit: 255
    t.string   "known_for_link5",               limit: 255
    t.string   "lastActivity5",                 limit: 255
    t.string   "lastActivity1Date",             limit: 255
    t.string   "lastActivity2Date",             limit: 255
    t.string   "lastActivity3Date",             limit: 255
    t.string   "lastActivity4Date",             limit: 255
    t.string   "lastActivity5Date",             limit: 255
    t.string   "lastActivity1Action",           limit: 255
    t.string   "lastActivity2Action",           limit: 255
    t.string   "lastActivity3Action",           limit: 255
    t.string   "lastActivity4Action",           limit: 255
    t.string   "lastActivity5Action",           limit: 255
    t.text     "lastActivity1Outcome",          limit: 4294967295
    t.text     "lastActivity2Outcome",          limit: 4294967295
    t.text     "lastActivity3Outcome",          limit: 4294967295
    t.text     "lastActivity4Outcome",          limit: 4294967295
    t.text     "lastActivity5Outcome",          limit: 4294967295
    t.string   "political_experience1",         limit: 255
    t.string   "political_experience2",         limit: 255
    t.string   "political_experience3",         limit: 255
    t.string   "political_experience4",         limit: 255
    t.string   "political_experience5",         limit: 255
    t.text     "political_experience1_content", limit: 65535
    t.text     "political_experience2_content", limit: 65535
    t.text     "political_experience3_content", limit: 65535
    t.text     "political_experience4_content", limit: 65535
    t.text     "political_experience5_content", limit: 65535
    t.text     "political_experience1_date",    limit: 65535
    t.text     "political_experience2_date",    limit: 65535
    t.text     "political_experience3_date",    limit: 65535
    t.text     "political_experience4_date",    limit: 65535
    t.text     "political_experience5_date",    limit: 65535
    t.text     "school",                        limit: 65535
    t.text     "family",                        limit: 65535
    t.text     "pinterest",                     limit: 65535
    t.text     "gender",                        limit: 65535
    t.integer  "region_id",                     limit: 4
    t.text     "lastActivity1Link",             limit: 65535
    t.text     "lastActivity2Link",             limit: 65535
    t.text     "lastActivity3Link",             limit: 65535
    t.text     "lastActivity4Link",             limit: 65535
    t.text     "lastActivity5Link",             limit: 65535
    t.string   "cause6",                        limit: 255
  end

  create_table "geo_area_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "geo_areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "category",   limit: 4
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "permission", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "political_parties", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.decimal  "leaning_index",               precision: 64, scale: 12
    t.decimal  "decimal",                     precision: 64, scale: 12
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "region_id",     limit: 4
    t.text     "image",         limit: 65535
  end

  create_table "regions", force: :cascade do |t|
    t.string   "iso3166_2",  limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "scraped",                default: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "role_id",                limit: 4
    t.string   "full_name",              limit: 255
    t.integer  "supervisor",             limit: 4
    t.boolean  "status",                             default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255,        null: false
    t.integer  "item_id",        limit: 4,          null: false
    t.string   "event",          limit: 255,        null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "object_changes", limit: 4294967295
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
