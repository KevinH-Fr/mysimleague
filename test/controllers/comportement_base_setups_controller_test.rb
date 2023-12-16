require "test_helper"

class ComportementBaseSetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comportement_base_setup = comportement_base_setups(:one)
  end

  test "should get index" do
    get comportement_base_setups_url
    assert_response :success
  end

  test "should get new" do
    get new_comportement_base_setup_url
    assert_response :success
  end

  test "should create comportement_base_setup" do
    assert_difference("ComportementBaseSetup.count") do
      post comportement_base_setups_url, params: { comportement_base_setup: { base_setup_id: @comportement_base_setup.base_setup_id, comportement_id: @comportement_base_setup.comportement_id, sens: @comportement_base_setup.sens } }
    end

    assert_redirected_to comportement_base_setup_url(ComportementBaseSetup.last)
  end

  test "should show comportement_base_setup" do
    get comportement_base_setup_url(@comportement_base_setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_comportement_base_setup_url(@comportement_base_setup)
    assert_response :success
  end

  test "should update comportement_base_setup" do
    patch comportement_base_setup_url(@comportement_base_setup), params: { comportement_base_setup: { base_setup_id: @comportement_base_setup.base_setup_id, comportement_id: @comportement_base_setup.comportement_id, sens: @comportement_base_setup.sens } }
    assert_redirected_to comportement_base_setup_url(@comportement_base_setup)
  end

  test "should destroy comportement_base_setup" do
    assert_difference("ComportementBaseSetup.count", -1) do
      delete comportement_base_setup_url(@comportement_base_setup)
    end

    assert_redirected_to comportement_base_setups_url
  end
end
