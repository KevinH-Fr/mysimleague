require "test_helper"

class BaseSetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @base_setup = base_setups(:one)
  end

  test "should get index" do
    get base_setups_url
    assert_response :success
  end

  test "should get new" do
    get new_base_setup_url
    assert_response :success
  end

  test "should create base_setup" do
    assert_difference("BaseSetup.count") do
      post base_setups_url, params: { base_setup: { explication: @base_setup.explication, parametre: @base_setup.parametre, val_max: @base_setup.val_max, val_min: @base_setup.val_min } }
    end

    assert_redirected_to base_setup_url(BaseSetup.last)
  end

  test "should show base_setup" do
    get base_setup_url(@base_setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_base_setup_url(@base_setup)
    assert_response :success
  end

  test "should update base_setup" do
    patch base_setup_url(@base_setup), params: { base_setup: { explication: @base_setup.explication, parametre: @base_setup.parametre, val_max: @base_setup.val_max, val_min: @base_setup.val_min } }
    assert_redirected_to base_setup_url(@base_setup)
  end

  test "should destroy base_setup" do
    assert_difference("BaseSetup.count", -1) do
      delete base_setup_url(@base_setup)
    end

    assert_redirected_to base_setups_url
  end
end
