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

ActiveRecord::Schema.define(:version => 20111209104535) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.string   "title"
    t.string   "byline"
    t.text     "body"
    t.datetime "publish_at"
    t.integer  "visibility",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
    t.text     "editor_comments"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "byline"
    t.text     "body"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  create_table "editors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privilege_lists", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "addresses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "member"
    t.boolean  "admin",           :default => false
    t.boolean  "suspended",       :default => false
  end

end
