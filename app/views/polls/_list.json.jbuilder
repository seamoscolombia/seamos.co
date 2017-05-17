json.polls do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.type poll.poll_type
  end
end
