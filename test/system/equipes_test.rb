require "application_system_test_case"

class EquipesTest < ApplicationSystemTestCase
  setup do
    @equipe = equipes(:one)
  end

  test "visiting the index" do
    visit equipes_url
    assert_selector "h1", text: "Equipes"
  end

  test "should create equipe" do
    visit equipes_url
    click_on "New equipe"

    fill_in "Couleur", with: @equipe.couleur
    fill_in "Nom", with: @equipe.nom
    click_on "Create Equipe"

    assert_text "Equipe was successfully created"
    click_on "Back"
  end

  test "should update Equipe" do
    visit equipe_url(@equipe)
    click_on "Edit this equipe", match: :first

    fill_in "Couleur", with: @equipe.couleur
    fill_in "Nom", with: @equipe.nom
    click_on "Update Equipe"

    assert_text "Equipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Equipe" do
    visit equipe_url(@equipe)
    click_on "Destroy this equipe", match: :first

    assert_text "Equipe was successfully destroyed"
  end
end
