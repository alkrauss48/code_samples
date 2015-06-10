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

ActiveRecord::Schema.define(:version => 20120921021704) do

  create_table "bills", :force => true do |t|
    t.string   "company"
    t.decimal  "total_amount", :precision => 10, :scale => 0
    t.date     "due_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "breakdowns", :force => true do |t|
    t.decimal  "amount",         :precision => 10, :scale => 0
    t.date     "pay_date"
    t.boolean  "late_payment"
    t.boolean  "missed_payment"
    t.integer  "member_id"
    t.integer  "bill_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "breakdowns", ["bill_id"], :name => "index_breakdowns_on_bill_id"
  add_index "breakdowns", ["member_id"], :name => "index_breakdowns_on_member_id"

  create_table "members", :force => true do |t|
    t.string   "initials"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
