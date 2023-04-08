require "test_helper"

class LiguesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ligue = ligues(:one)
  end

  test "should get index" do
    get ligues_url
    assert_response :success
  end

  test "should get new" do
    get new_ligue_url
    assert_response :success
  end

  test "should create ligue" do
    assert_difference("Ligue.count") do
      post ligues_url, params: { ligue: { description: @ligue.description, nom: @ligue.nom } }
    end

    assert_redirected_to ligue_url(Ligue.last)
  end

  test "should show ligue" do
    get ligue_url(@ligue)
    assert_response :success
  end

  test "should get edit" do
    get edit_ligue_url(@ligue)
    assert_response :success
  end

  test "should update ligue" do
    patch ligue_url(@ligue), params: { ligue: { description: @ligue.description, nom: @ligue.nom } }
    assert_redirected_to ligue_url(@ligue)
  end

  test "should destroy ligue" do
    assert_difference("Ligue.count", -1) do
      delete ligue_url(@ligue)
    end

    assert_redirected_to ligues_url
  end
end
