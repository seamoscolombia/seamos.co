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

ActiveRecord::Schema.define(version: 20170322154417) do

  create_table "causes", force: :cascade do |t|
    t.text     "description"
    t.string   "title"
    t.integer  "usuario_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["usuario_id"], name: "index_causes_on_usuario_id"
  end

  create_table "coldocuments", id: false, force: :cascade do |t|
    t.integer "doc_num",    limit: 8
    t.integer "divipol_id", limit: 8
    t.index ["divipol_id"], name: "index_coldocuments_on_divipol_id"
    t.index ["doc_num"], name: "index_coldocuments_on_doc_num"
  end

  create_table "debate_votes", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "usuario_id"
    t.integer  "debate_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["debate_id"], name: "index_debate_votes_on_debate_id"
    t.index ["question_id"], name: "index_debate_votes_on_question_id"
    t.index ["usuario_id"], name: "index_debate_votes_on_usuario_id"
  end

  create_table "debates", force: :cascade do |t|
    t.string   "title"
    t.boolean  "published",  default: false
    t.integer  "poll_id"
    t.integer  "usuario_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["poll_id"], name: "index_debates_on_poll_id"
    t.index ["usuario_id"], name: "index_debates_on_usuario_id"
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
    t.index ["code"], name: "index_globals_on_code", unique: true
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["departamento_id"], name: "index_municipios_on_departamento_id"
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
    t.index ["title"], name: "index_polls_on_title"
    t.index ["usuario_id"], name: "index_polls_on_usuario_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "description", null: false
    t.integer  "debate_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["debate_id"], name: "index_questions_on_debate_id"
  end

  create_table "tipo_de_documentos", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_tipo_de_documentos_on_codigo", unique: true
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "nombres"
    t.integer  "tipo_de_documento_id"
    t.string   "numero_documento"
    t.date     "fecha_expedicion"
    t.integer  "role_id"
    t.string   "uid"
    t.boolean  "valido"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "document_photo_id"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.index ["document_photo_id"], name: "index_usuarios_on_document_photo_id"
    t.index ["numero_documento"], name: "index_usuarios_on_numero_documento"
    t.index ["role_id"], name: "index_usuarios_on_role_id"
    t.index ["tipo_de_documento_id", "numero_documento"], name: "index_usuarios_on_tipo_de_documento_id_and_numero_documento", unique: true
    t.index ["tipo_de_documento_id"], name: "index_usuarios_on_tipo_de_documento_id"
    t.index ["uid"], name: "index_usuarios_on_uid", unique: true
  end

  create_table "vote_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_vote_types_on_poll_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "usuario_id"
    t.integer  "vote_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["usuario_id"], name: "index_votes_on_usuario_id"
    t.index ["vote_type_id"], name: "index_votes_on_vote_type_id"
  end

end
