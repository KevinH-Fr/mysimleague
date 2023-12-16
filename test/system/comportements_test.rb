require "application_system_test_case"

class ComportementsTest < ApplicationSystemTestCase
  setup do
    @comportement = comportements(:one)
  end

  test "visiting the index" do
    visit comportements_url
    assert_selector "h1", text: "Comportements"
  end

  test "should create comportement" do
    visit comportements_url
    click_on "New comportement"

    fill_in "Label categorie", with: @comportement.label_categorie
    fill_in "Nom", with: @comportement.nom
    check "Principal" if @comportement.principal
    click_on "Create Comportement"

    assert_text "Comportement was successfully created"
    click_on "Back"
  end

  test "should update Comportement" do
    visit comportement_url(@comportement)
    click_on "Edit this comportement", match: :first

    fill_in "Label categorie", with: @comportement.label_categorie
    fill_in "Nom", with: @comportement.nom
    check "Principal" if @comportement.principal
    click_on "Update Comportement"

    assert_text "Comportement was successfully updated"
    click_on "Back"
  end

  test "should destroy Comportement" do
    visit comportement_url(@comportement)
    click_on "Destroy this comportement", match: :first

    assert_text "Comportement was successfully destroyed"
  end
end
