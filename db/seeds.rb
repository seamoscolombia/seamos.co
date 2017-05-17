user = User.create!(email: 'jasmo@gmail.com', password: "123456", password_confirmation: "123456", first_surname: "Molina", second_surname: "Orbe", names: "Jaime Santiago", role_type: 2, uid: "10152902624895489", approved: false)

# poll = Poll.create!(
#     title: Faker::Lorem.sentence,
#     description: Faker::Lorem.paragraph,
#     closing_date: 1.day.from_now,
#     usuario_id: user.id
# )
# prng = Random.new
# coldocuemts = Coldocument.all.limit 400
# 400.times  do |index|
#   cc = coldocuemts[index].doc_num
#   puts "cc: #{cc}"
#   u = Usuario.create!(
#       first_surname: Faker::Lorem.word,
#       segundo_apellido: Faker::Lorem.word,
#       nombres: Faker::Lorem.word,
#       tipo_de_documento_id: 1,
#       numero_documento: cc,
#       fecha_expedicion: Faker::Time.between(3.years.ago, 1.year.ago),
#       role_id: 1,
#       uid: Faker::Number.number(10).to_s ,
#       approved: false
#   )
#
#
#   vote = Vote.create!(
#     poll: poll,
#     usuario: u,
#     vote_type_id: prng.rand(1..3)
#   )
# end
