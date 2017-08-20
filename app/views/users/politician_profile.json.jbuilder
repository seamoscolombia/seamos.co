url = Rails.env.production? ? '' : 'http://localhost:3000'
json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.short_name "#{@user.names}  #{@user.first_surname}"
  json.organization @user.organization
  json.bio @user.bio
  json.picture @user.admin_photo.url
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
      json.politician do
        json.id poll.user.id
        json.full_name poll.user.full_name
        json.picture url + poll.user.admin_photo.url if poll.user.admin_photo.url
        # json.picture "${url}${politician_profile_picture}"
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
