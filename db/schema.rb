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

ActiveRecord::Schema.define(version: 20160719200049) do

  create_table "departamentos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "globales", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.string   "valor",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_globales_on_codigo"
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["departamento_id"], name: "index_municipios_on_departamento_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_de_documentos", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "nombres"
    t.integer  "tipo_de_documento_id"
    t.string   "numero_documento"
    t.date     "fecha_expedicion"
    t.integer  "rol_id"
    t.string   "nombre_usuario"
    t.string   "password_digest"
    t.boolean  "valido"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["rol_id"], name: "index_usuarios_on_rol_id"
    t.index ["tipo_de_documento_id"], name: "index_usuarios_on_tipo_de_documento_id"
  end

end
