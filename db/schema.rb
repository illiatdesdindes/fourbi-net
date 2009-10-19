# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091019163539) do

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "utilisateurs", :force => true do |t|
    t.string   "login",           :limit => 20, :null => false
    t.string   "nom",             :limit => 40, :null => false
    t.string   "email",           :limit => 40, :null => false
    t.string   "hashed_password",               :null => false
    t.string   "salt",                          :null => false
    t.boolean  "site_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "utilisateurs", ["login"], :name => "index_utilisateurs_on_login", :unique => true
  add_index "utilisateurs", ["nom"], :name => "index_utilisateurs_on_nom", :unique => true

end
