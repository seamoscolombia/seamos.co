json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.tags do
    json.array! @user.tags do |tag|
      json.id tag.id
      json.name tag.name
      json.image tag.tag_image.url
      json.icon tag.tag_icon.url
      json.color tag.tag_color
    end
  end
  json.participations do
    json.count @participations.size
      json.polls do
        json.array! @participations do |poll|
          json.id poll.id
          json.title poll.title
          json.description poll.description
          json.type poll.poll_type
          json.poll_image poll.poll_image.url
          json.vote_count poll.votes.size
          json.remaining poll.remaining_time_in_seconds
          json.tag do
            json.tag_color poll.tags.first.tag_color
          end
        end
    end
  end
  json.authenticity_token form_authenticity_token
end
