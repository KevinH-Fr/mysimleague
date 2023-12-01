require "test_helper"

class StripeControllerTest < ActionDispatch::IntegrationTest
  test "should get purchase_success" do
    get stripe_purchase_success_url
    assert_response :success
  end
end
