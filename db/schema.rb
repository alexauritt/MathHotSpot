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

ActiveRecord::Schema.define(:version => 20110710104842) do

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructions", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.integer  "chapter"
    t.integer  "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.integer  "category_id"
    t.integer  "owner_id"
  end

  create_table "lessons_problem_types", :id => false, :force => true do |t|
    t.integer "lesson_id",       :null => false
    t.integer "problem_type_id", :null => false
  end

  create_table "math_problems", :force => true do |t|
    t.integer  "problem_level_id"
    t.text     "question_markup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "answer_markup"
  end

  create_table "problem_levels", :force => true do |t|
    t.integer  "problem_type_id"
    t.integer  "level_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_types", :force => true do |t|
    t.integer  "instruction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "display_mode",   :default => true
    t.string   "title"
    t.string   "permalink"
    t.integer  "owner_id"
    t.integer  "category_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "worksheet_problems", :force => true do |t|
    t.integer  "worksheet_id"
    t.integer  "math_problem_id"
    t.integer  "problem_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worksheets", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
