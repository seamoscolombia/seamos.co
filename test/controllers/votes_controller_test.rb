require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test "should get yes" do
    get votes_yes_url
    assert_response :success
  end

  test "should get no" do
    get votes_no_url
    assert_response :success
  end

  test "should get blank" do
    get votes_blank_url
    assert_response :success
  end

end
