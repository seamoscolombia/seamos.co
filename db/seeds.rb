# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TipoDeDocumento.create!(codigo: 'cedula')
TipoDeDocumento.create!(codigo: 'cedula_extranjeria')

Rol.create!(codigo: 'ciudadano')
Rol.create!(codigo: 'politico')
Rol.create!(codigo: 'administrador')
