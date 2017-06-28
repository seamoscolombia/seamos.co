json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.short_name "#{@user.names}  #{@user.first_surname}"
  json.organization @user.organization
  json.bio @user.bio
  json.polls do
    json.array! @polls do |poll|
      json.id poll.id
      json.title poll.title
      json.description poll.description
      json.type poll.poll_type
      json.poll_image poll.poll_image.url
      json.vote_count poll.votes.size
      json.remaining poll.remaining_time_in_seconds
      json.tag do
        json.color poll.tags.first.tag_color
      end
    end
  end
  json.closed_polls do
    json.array! @closed_polls do |poll|
      json.id poll.id
      json.title poll.title
      json.description poll.description
      json.type poll.poll_type
      json.poll_image poll.poll_image.url
      json.vote_count poll.votes.size
      json.remaining poll.remaining_time_in_seconds
      json.tag do
        json.color poll.tags.first.tag_color
      end
    end
  end
  json.authenticity_token form_authenticity_token
end
