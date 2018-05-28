require 'test_helper'

class SquadControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get squad_new_url
    assert_response :success
  end

  test "should get show" do
    get squad_show_url
    assert_response :success
  end

end
