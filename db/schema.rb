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

ActiveRecord::Schema.define(version: 20150929112523) do

  create_table "countries", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.string   "source",       limit: 255
    t.boolean  "scraped",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "scraper",      limit: 255
  end

  create_table "data", force: :cascade do |t|
    t.string   "sourceWebsite",            limit: 255
    t.string   "name",                     limit: 255
    t.string   "picture",                  limit: 255
    t.string   "politicalParty",           limit: 255
    t.string   "politicalPartyImage",      limit: 255
    t.string   "verified",                 limit: 255
    t.integer  "likes",                    limit: 4
    t.integer  "followers",                limit: 4
    t.string   "email",                    limit: 255
    t.string   "twitter",                  limit: 255
    t.string   "facebook",                 limit: 255
    t.string   "linkedin",                 limit: 255
    t.string   "googlePlus",               limit: 255
    t.string   "instagram",                limit: 255
    t.string   "blog",                     limit: 255
    t.string   "youtubeChannel",           limit: 255
    t.string   "premium",                  limit: 255
    t.text     "bio",                      limit: 65535
    t.text     "quote1",                   limit: 65535
    t.text     "quote2",                   limit: 65535
    t.string   "sourceActivity",           limit: 255
    t.text     "lastActivity1",            limit: 65535
    t.text     "lastActivity2",            limit: 65535
    t.text     "lastActivity3",            limit: 65535
    t.text     "lastActivity4",            limit: 65535
    t.integer  "ideology1",                limit: 4
    t.integer  "ideology2",                limit: 4
    t.integer  "ideology3",                limit: 4
    t.integer  "ideology4",                limit: 4
    t.integer  "ideology5",                limit: 4
    t.integer  "following",                limit: 4
    t.integer  "openProjects",             limit: 4
    t.integer  "closedProjects",           limit: 4
    t.integer  "proposals",                limit: 4
    t.integer  "debates",                  limit: 4
    t.integer  "sponsorships",             limit: 4
    t.integer  "victories",                limit: 4
    t.string   "dateOfBirth",              limit: 255
    t.string   "placeOfBirth",             limit: 255
    t.text     "institutionalAddress",     limit: 65535
    t.string   "institutionalTelephone",   limit: 255
    t.string   "institutionalFax",         limit: 255
    t.string   "institutionalMobilePhone", limit: 255
    t.string   "electoralAddress",         limit: 255
    t.string   "electoralTelephone",       limit: 255
    t.string   "electoralFax",             limit: 255
    t.string   "electoralMobile",          limit: 255
    t.string   "phone",                    limit: 255
    t.string   "assistants",               limit: 255
    t.string   "completeName",             limit: 255
    t.string   "position",                 limit: 255
    t.string   "region",                   limit: 255
    t.string   "institution",              limit: 255
    t.string   "constituency",             limit: 255
    t.string   "studies",                  limit: 255
    t.string   "university",               limit: 255
    t.string   "profession",               limit: 255
    t.string   "cvLink",                   limit: 255
    t.string   "declarationLink",          limit: 255
    t.string   "officialWebsite",          limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "iso3166_2",  limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
