
TipoDeDocumento.create!(codigo: 'cedula')
TipoDeDocumento.create!(codigo: 'cedula_extranjeria')

Role.create!(code: 'ciudadano')
Role.create!(code: 'politico')
Role.create!(code: 'administrador')

user = Usuario.create!(primer_apellido: "Molina", segundo_apellido: "Orbe", nombres: "Jaime Santiago", tipo_de_documento_id: 1, numero_documento: "1113645710", fecha_expedicion: "2011-05-28", role_id: 3, uid: "10152902624895489", valido: false)

# poll = Poll.create!(
#     title: Faker::Lorem.sentence,
#     description: Faker::Lorem.paragraph,
#     private: false,
#     closing_date: 1.day.from_now,
#     usuario_id: user.id
# )
# prng = Random.new
# coldocuemts = Coldocument.all.limit 400
# 400.times  do |index|
#   cc = coldocuemts[index].doc_num
#   puts "cc: #{cc}"
#   u = Usuario.create!(
#       primer_apellido: Faker::Lorem.word,
#       segundo_apellido: Faker::Lorem.word,
#       nombres: Faker::Lorem.word,
#       tipo_de_documento_id: 1,
#       numero_documento: cc,
#       fecha_expedicion: Faker::Time.between(3.years.ago, 1.year.ago),
#       role_id: 1,
#       uid: Faker::Number.number(10).to_s ,
#       valido: false
#   )
#
#
#   vote = Vote.create!(
#     poll: poll,
#     usuario: u,
#     vote_type_id: prng.rand(1..3)
#   )
# end
