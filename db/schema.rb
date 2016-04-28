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

ActiveRecord::Schema.define(version: 20160423065635) do

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "votes"
    t.boolean  "is_answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id", "question_id", "created_at"], name: "index_answers_on_user_id_and_question_id_and_created_at"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["answer_id"], name: "index_comments_on_answer_id"
  add_index "comments", ["question_id"], name: "index_comments_on_question_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["user_id", "created_at"], name: "index_questions_on_user_id_and_created_at"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "votes", ["answer_id"], name: "index_votes_on_answer_id"
  add_index "votes", ["question_id"], name: "index_votes_on_question_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
