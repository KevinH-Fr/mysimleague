require "test_helper"

class CategorieParametresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @categorie_parametre = categorie_parametres(:one)
  end

  test "should get index" do
    get categorie_parametres_url
    assert_response :success
  end

  test "should get new" do
    get new_categorie_parametre_url
    assert_response :success
  end

  test "should create categorie_parametre" do
    assert_difference("CategorieParametre.count") do
      post categorie_parametres_url, params: { categorie_parametre: { game_id: @categorie_parametre.game_id, val_categorie: @categorie_parametre.val_categorie } }
    end

    assert_redirected_to categorie_parametre_url(CategorieParametre.last)
  end

  test "should show categorie_parametre" do
    get categorie_parametre_url(@categorie_parametre)
    assert_response :success
  end

  test "should get edit" do
    get edit_categorie_parametre_url(@categorie_parametre)
    assert_response :success
  end

  test "should update categorie_parametre" do
    patch categorie_parametre_url(@categorie_parametre), params: { categorie_parametre: { game_id: @categorie_parametre.game_id, val_categorie: @categorie_parametre.val_categorie } }
    assert_redirected_to categorie_parametre_url(@categorie_parametre)
  end

  test "should destroy categorie_parametre" do
    assert_difference("CategorieParametre.count", -1) do
      delete categorie_parametre_url(@categorie_parametre)
    end

    assert_redirected_to categorie_parametres_url
  end
end
