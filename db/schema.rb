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

ActiveRecord::Schema.define(:version => 20110405180707) do

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
  end

  create_table "math_problem_templates", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "instructions_id"
    t.integer  "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "math_problems", :force => true do |t|
    t.integer  "math_problem_template_id"
    t.text     "question_markup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "answer_markup"
  end

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
