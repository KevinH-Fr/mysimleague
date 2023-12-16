require "application_system_test_case"

class CategorieParametresTest < ApplicationSystemTestCase
  setup do
    @categorie_parametre = categorie_parametres(:one)
  end

  test "visiting the index" do
    visit categorie_parametres_url
    assert_selector "h1", text: "Categorie parametres"
  end

  test "should create categorie parametre" do
    visit categorie_parametres_url
    click_on "New categorie parametre"

    fill_in "Game", with: @categorie_parametre.game_id
    fill_in "Val categorie", with: @categorie_parametre.val_categorie
    click_on "Create Categorie parametre"

    assert_text "Categorie parametre was successfully created"
    click_on "Back"
  end

  test "should update Categorie parametre" do
    visit categorie_parametre_url(@categorie_parametre)
    click_on "Edit this categorie parametre", match: :first

    fill_in "Game", with: @categorie_parametre.game_id
    fill_in "Val categorie", with: @categorie_parametre.val_categorie
    click_on "Update Categorie parametre"

    assert_text "Categorie parametre was successfully updated"
    click_on "Back"
  end

  test "should destroy Categorie parametre" do
    visit categorie_parametre_url(@categorie_parametre)
    click_on "Destroy this categorie parametre", match: :first

    assert_text "Categorie parametre was successfully destroyed"
  end
end
