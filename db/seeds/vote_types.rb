polls = Poll.all

polls.each do |poll|
  poll.vote_types.create!(name: "SI")
  poll.vote_types.create!(name: "NO")
end
