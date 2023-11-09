require "test_helper"

class LandingpageControllerTest < ActionDispatch::IntegrationTest
  test "should get home:index" do
    get landingpage_home:index_url
    assert_response :success
  end
end
