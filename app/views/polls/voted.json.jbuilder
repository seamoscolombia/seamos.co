json.polls do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.closing_date poll.closing_date
    json.poll_image "#{url}#{poll.poll_image_url}"
  end
end
