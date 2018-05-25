url = Rails.env.production? ? '' : 'http://localhost:3000'
json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.short_name "#{@user.names}  #{@user.first_surname}"
  json.birthplace @user.birthplace
  json.organization @user.organization
  json.twitter @user.twitter_username
  json.bio @user.bio
  json.picture @user.admin_photo.url
  json.commission @user.current_corporation_commission
  json.initiatives @user.proposed_initiatives_to_date
  json.last_vote_count @user.last_election_vote_count
  json.localities @user.major_electoral_representation_localities.split(',')
  json.represented_organizations @user.represented_organizations
  json.other_periods @user.other_periods_elected
  json.polls do
    json.array! @polls do |poll|
      json.id poll.id
      json.title poll.title
      json.poll_image poll.poll_image.url
      json.is_closed poll.closed?
      json.tag do
        json.color poll.tags.first.tag_color
        json.name poll.tags.first.name
      end
      json.politician do
        json.id @user.id
        json.full_name @user.full_name
        json.picture url + @user.admin_photo.url if @user.admin_photo.url
      end
    end
  end
  json.academic_titles do
    json.array! @user.academic_titles do |academic_title|
      json.title academic_title.title
      json.institute academic_title.institute
    end
  end
  json.authenticity_token form_authenticity_token
end
