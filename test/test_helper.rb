ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def init_session_json(uid,fb_token)
    post sessions_url, params: {
      uid: uid ,
      fb_token: fb_token
    }, as: :json
  end

  def init_omniAuth
    {
      :provider => 'facebook',
      :uid => 'fb_uid',
      :credentials => {:token => 'fb_token'},
      :info => {:image => "myimage"}
    }
  end
  # Add more helper methods to be used by all tests here...
end
