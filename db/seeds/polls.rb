u = Usuario.find_by(numero_documento: "1113645710")

poll = Poll.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    private: false,
    closing_date: 1.day.from_now,
    usuario_id: u.id
)