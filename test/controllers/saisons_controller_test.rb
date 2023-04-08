require "test_helper"

class SaisonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saison = saisons(:one)
  end

  test "should get index" do
    get saisons_url
    assert_response :success
  end

  test "should get new" do
    get new_saison_url
    assert_response :success
  end

  test "should create saison" do
    assert_difference("Saison.count") do
      post saisons_url, params: { saison: { nom: @saison.nom, numero: @saison.numero } }
    end

    assert_redirected_to saison_url(Saison.last)
  end

  test "should show saison" do
    get saison_url(@saison)
    assert_response :success
  end

  test "should get edit" do
    get edit_saison_url(@saison)
    assert_response :success
  end

  test "should update saison" do
    patch saison_url(@saison), params: { saison: { nom: @saison.nom, numero: @saison.numero } }
    assert_redirected_to saison_url(@saison)
  end

  test "should destroy saison" do
    assert_difference("Saison.count", -1) do
      delete saison_url(@saison)
    end

    assert_redirected_to saisons_url
  end
end
