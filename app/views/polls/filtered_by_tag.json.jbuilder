url = Rails.env.production? ? '' : 'http://localhost:3000'
json.filtered_by_tag do
  if @tag
    json.tag do
      json.image @tag.tag_image.url
      json.icon @tag.tag_icon.url
      json.color @tag.tag_color
      json.name @tag.name
    end
  end
  json.polls do
    json.array! @polls do |poll|
      json.id poll.id
      json.title poll.title
      json.description poll.description
      json.type poll.poll_type
      json.poll_image poll.poll_image.url
      json.vote_count poll.votes.size
      json.remaining poll.remaining_time_in_seconds
      json.summary poll.summary
      if current_user
        json.already_voted current_user.already_voted?(poll)
      else
        json.already_voted false
      end
      json.politician do
        json.id poll.user.id
        json.full_name poll.user.full_name
        json.picture url + poll.user.admin_photo.url if poll.user.admin_photo.url
        # json.picture "${url}${politician_profile_picture}"
      end
    end
  end
end
