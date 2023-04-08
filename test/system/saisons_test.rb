require "application_system_test_case"

class SaisonsTest < ApplicationSystemTestCase
  setup do
    @saison = saisons(:one)
  end

  test "visiting the index" do
    visit saisons_url
    assert_selector "h1", text: "Saisons"
  end

  test "should create saison" do
    visit saisons_url
    click_on "New saison"

    fill_in "Nom", with: @saison.nom
    fill_in "Numero", with: @saison.numero
    click_on "Create Saison"

    assert_text "Saison was successfully created"
    click_on "Back"
  end

  test "should update Saison" do
    visit saison_url(@saison)
    click_on "Edit this saison", match: :first

    fill_in "Nom", with: @saison.nom
    fill_in "Numero", with: @saison.numero
    click_on "Update Saison"

    assert_text "Saison was successfully updated"
    click_on "Back"
  end

  test "should destroy Saison" do
    visit saison_url(@saison)
    click_on "Destroy this saison", match: :first

    assert_text "Saison was successfully destroyed"
  end
end
