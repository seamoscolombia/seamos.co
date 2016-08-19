require 'test_helper'

class IntroControllerTest < ActionDispatch::IntegrationTest
  test "should get inicio" do
    get root_path
    assert_response :success
  end

end
