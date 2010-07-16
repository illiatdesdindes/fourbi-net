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

ActiveRecord::Schema.define(:version => 20100716181155) do

  create_table "article_clients", :force => true do |t|
    t.integer "article_id",    :null => false
    t.integer "client_id",     :null => false
    t.integer "quantite",      :null => false
    t.float   "prix_unitaire", :null => false
  end

  add_index "article_clients", ["article_id", "client_id"], :name => "index_article_clients_on_article_id_and_client_id", :unique => true

  create_table "articles", :force => true do |t|
    t.string   "nom",                :null => false
    t.text     "description_courte"
    t.integer  "numero",             :null => false
    t.integer  "serie_id",           :null => false
    t.integer  "nombre_restant",     :null => false
    t.float    "prix",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description_longue"
  end

  add_index "articles", ["nombre_restant"], :name => "index_articles_on_nombre_restant"
  add_index "articles", ["numero"], :name => "index_articles_on_numero"
  add_index "articles", ["serie_id"], :name => "index_articles_on_serie_id"

  create_table "boutiques", :force => true do |t|
    t.string   "nom",         :null => false
    t.integer  "numero",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "boutiques", ["nom"], :name => "index_boutiques_on_nom", :unique => true
  add_index "boutiques", ["numero"], :name => "index_boutiques_on_numero", :unique => true

  create_table "clients", :force => true do |t|
    t.string   "identifiant",   :null => false
    t.text     "adresse",       :null => false
    t.string   "code_postal"
    t.string   "ville"
    t.string   "pays",          :null => false
    t.string   "email",         :null => false
    t.string   "status",        :null => false
    t.datetime "date_paiement"
    t.float    "prix",          :null => false
    t.datetime "date_envoi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["date_envoi"], :name => "index_clients_on_date_envoi"
  add_index "clients", ["status"], :name => "index_clients_on_status"

  create_table "metas", :force => true do |t|
    t.string "nom",     :null => false
    t.text   "contenu", :null => false
  end

  add_index "metas", ["nom"], :name => "index_metas_on_nom", :unique => true

  create_table "series", :force => true do |t|
    t.string   "nom",         :null => false
    t.integer  "numero",      :null => false
    t.integer  "boutique_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "series", ["boutique_id"], :name => "index_series_on_boutique_id"
  add_index "series", ["numero"], :name => "index_series_on_numero"

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

  create_table "vues", :force => true do |t|
    t.integer  "article_id",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vues", ["article_id"], :name => "index_vues_on_article_id"

end
