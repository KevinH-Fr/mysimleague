require "test_helper"

class SetupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setup = setups(:one)
  end

  test "should get index" do
    get setups_url
    assert_response :success
  end

  test "should get new" do
    get new_setup_url
    assert_response :success
  end

  test "should create setup" do
    assert_difference("Setup.count") do
      post setups_url, params: { setup: { game_id: @setup.game_id, nom: @setup.nom } }
    end

    assert_redirected_to setup_url(Setup.last)
  end

  test "should show setup" do
    get setup_url(@setup)
    assert_response :success
  end

  test "should get edit" do
    get edit_setup_url(@setup)
    assert_response :success
  end

  test "should update setup" do
    patch setup_url(@setup), params: { setup: { game_id: @setup.game_id, nom: @setup.nom } }
    assert_redirected_to setup_url(@setup)
  end

  test "should destroy setup" do
    assert_difference("Setup.count", -1) do
      delete setup_url(@setup)
    end

    assert_redirected_to setups_url
  end
end
