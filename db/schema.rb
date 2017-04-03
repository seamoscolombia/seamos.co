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

ActiveRecord::Schema.define(version: 20170328161549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "causes", force: :cascade do |t|
    t.text     "description",    null: false
    t.string   "title",          null: false
    t.integer  "state_cause_id", null: false
    t.integer  "usuario_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["state_cause_id"], name: "index_causes_on_state_cause_id", using: :btree
    t.index ["usuario_id"], name: "index_causes_on_usuario_id", using: :btree
  end

  create_table "coldocuments", id: false, force: :cascade do |t|
    t.bigint "doc_num"
    t.bigint "divipol_id"
    t.index ["divipol_id"], name: "index_coldocuments_on_divipol_id", using: :btree
    t.index ["doc_num"], name: "index_coldocuments_on_doc_num", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "description", null: false
    t.integer  "usuario_id",  null: false
    t.integer  "cause_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cause_id"], name: "index_comments_on_cause_id", using: :btree
    t.index ["usuario_id"], name: "index_comments_on_usuario_id", using: :btree
  end

  create_table "debate_votes", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "usuario_id"
    t.integer  "debate_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["debate_id"], name: "index_debate_votes_on_debate_id", using: :btree
    t.index ["question_id"], name: "index_debate_votes_on_question_id", using: :btree
    t.index ["usuario_id"], name: "index_debate_votes_on_usuario_id", using: :btree
  end

  create_table "debates", force: :cascade do |t|
    t.string   "title"
    t.boolean  "published",  default: false
    t.integer  "poll_id"
    t.integer  "usuario_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["poll_id"], name: "index_debates_on_poll_id", using: :btree
    t.index ["usuario_id"], name: "index_debates_on_usuario_id", using: :btree
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_photos", force: :cascade do |t|
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "globals", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_globals_on_code", unique: true, using: :btree
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["departamento_id"], name: "index_municipios_on_departamento_id", using: :btree
  end

  create_table "polls", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.boolean  "private",      default: true, null: false
    t.date     "closing_date",                null: false
    t.integer  "usuario_id"
    t.string   "totals"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "poll_image"
    t.boolean  "active",       default: true
    t.index ["title"], name: "index_polls_on_title", using: :btree
    t.index ["usuario_id"], name: "index_polls_on_usuario_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "description", null: false
    t.integer  "debate_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["debate_id"], name: "index_questions_on_debate_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_roles_on_code", unique: true, using: :btree
  end

  create_table "state_causes", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_de_documentos", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_tipo_de_documentos_on_codigo", unique: true, using: :btree
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "nombres"
    t.integer  "tipo_de_documento_id"
    t.string   "numero_documento"
    t.date     "fecha_expedicion"
    t.integer  "role_type"
    t.string   "uid"
    t.boolean  "valido"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "document_photo_id"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.index ["document_photo_id"], name: "index_usuarios_on_document_photo_id", using: :btree
    t.index ["numero_documento"], name: "index_usuarios_on_numero_documento", using: :btree
    t.index ["role_type"], name: "index_usuarios_on_role_type", using: :btree
    t.index ["tipo_de_documento_id", "numero_documento"], name: "index_usuarios_on_tipo_de_documento_id_and_numero_documento", unique: true, using: :btree
    t.index ["tipo_de_documento_id"], name: "index_usuarios_on_tipo_de_documento_id", using: :btree
    t.index ["uid"], name: "index_usuarios_on_uid", unique: true, using: :btree
  end

  create_table "vote_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_vote_types_on_poll_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "usuario_id"
    t.integer  "vote_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["poll_id"], name: "index_votes_on_poll_id", using: :btree
    t.index ["usuario_id"], name: "index_votes_on_usuario_id", using: :btree
    t.index ["vote_type_id"], name: "index_votes_on_vote_type_id", using: :btree
  end

  add_foreign_key "causes", "state_causes"
  add_foreign_key "causes", "usuarios"
  add_foreign_key "comments", "causes"
  add_foreign_key "comments", "usuarios"
  add_foreign_key "debate_votes", "debates"
  add_foreign_key "debate_votes", "usuarios"
  add_foreign_key "debates", "polls"
  add_foreign_key "debates", "usuarios"
  add_foreign_key "municipios", "departamentos"
  add_foreign_key "polls", "usuarios"
  add_foreign_key "questions", "debates"
  add_foreign_key "usuarios", "document_photos"
  add_foreign_key "usuarios", "roles", column: "role_type"
  add_foreign_key "usuarios", "tipo_de_documentos"
  add_foreign_key "vote_types", "polls"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "usuarios"
end
