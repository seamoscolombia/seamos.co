require 'test_helper'

class IntroControllerTest < ActionDispatch::IntegrationTest
  test "should get inicio" do
    get intro_inicio_url
    assert_response :success
  end

end
