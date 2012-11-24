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

ActiveRecord::Schema.define(:version => 20121124061303) do

  create_table "choices", :force => true do |t|
    t.integer  "question_id", :null => false
    t.text     "value"
    t.boolean  "correct"
    t.text     "reason"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "objectives", :force => true do |t|
    t.integer  "topic_id"
    t.string   "name",       :null => false
    t.string   "grade"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "objectives", ["topic_id", "grade"], :name => "index_objectives_on_topic_id_and_grade"

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "objective_id"
    t.integer  "difficulty",    :default => 0
    t.integer  "solution_type"
    t.text     "hint"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "questions", ["objective_id", "difficulty"], :name => "index_questions_on_objective_id_and_difficulty"

  create_table "subjects", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "subject_id"
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["subject_id"], :name => "index_topics_on_subject_id"

end
