require 'test_helper'

class VenueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get venue_index_url
    assert_response :success
  end

  test "should get show" do
    get venue_show_url
    assert_response :success
  end

end
