require "test_helper"

class ParametreSetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parametre_setup = parametre_setups(:one)
  end

  test "should get index" do
    get parametre_setups_url
    assert_response :success
  end

  test "should get new" do
    get new_parametre_setup_url
    assert_response :success
  end

  test "should create parametre_setup" do
    assert_difference("ParametreSetup.count") do
      post parametre_setups_url, params: { parametre_setup: { base_setup_id: @parametre_setup.base_setup_id, filled: @parametre_setup.filled, setup_id: @parametre_setup.setup_id, val_parametre: @parametre_setup.val_parametre } }
    end

    assert_redirected_to parametre_setup_url(ParametreSetup.last)
  end

  test "should show parametre_setup" do
    get parametre_setup_url(@parametre_setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_parametre_setup_url(@parametre_setup)
    assert_response :success
  end

  test "should update parametre_setup" do
    patch parametre_setup_url(@parametre_setup), params: { parametre_setup: { base_setup_id: @parametre_setup.base_setup_id, filled: @parametre_setup.filled, setup_id: @parametre_setup.setup_id, val_parametre: @parametre_setup.val_parametre } }
    assert_redirected_to parametre_setup_url(@parametre_setup)
  end

  test "should destroy parametre_setup" do
    assert_difference("ParametreSetup.count", -1) do
      delete parametre_setup_url(@parametre_setup)
    end

    assert_redirected_to parametre_setups_url
  end
end
