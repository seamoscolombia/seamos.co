u = User.find_by(numero_documento: "1113645710")

poll = Poll.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    closing_date: 1.day.from_now,
    user_id: u.id
)
