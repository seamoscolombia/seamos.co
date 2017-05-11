json.tags do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
  end
end
