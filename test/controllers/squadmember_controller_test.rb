require 'test_helper'

class SquadmemberControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get squadmember_create_url
    assert_response :success
  end

end
