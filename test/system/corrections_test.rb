require "application_system_test_case"

class CorrectionsTest < ApplicationSystemTestCase
  setup do
    @correction = corrections(:one)
  end

  test "visiting the index" do
    visit corrections_url
    assert_selector "h1", text: "Corrections"
  end

  test "should create correction" do
    visit corrections_url
    click_on "New correction"

    fill_in "Base setup", with: @correction.base_setup_id
    fill_in "Nom", with: @correction.nom
    fill_in "Probleme", with: @correction.probleme_id
    fill_in "Probleme second", with: @correction.probleme_second_id
    fill_in "Sens", with: @correction.sens
    fill_in "Setup", with: @correction.setup_id
    click_on "Create Correction"

    assert_text "Correction was successfully created"
    click_on "Back"
  end

  test "should update Correction" do
    visit correction_url(@correction)
    click_on "Edit this correction", match: :first

    fill_in "Base setup", with: @correction.base_setup_id
    fill_in "Nom", with: @correction.nom
    fill_in "Probleme", with: @correction.probleme_id
    fill_in "Probleme second", with: @correction.probleme_second_id
    fill_in "Sens", with: @correction.sens
    fill_in "Setup", with: @correction.setup_id
    click_on "Update Correction"

    assert_text "Correction was successfully updated"
    click_on "Back"
  end

  test "should destroy Correction" do
    visit correction_url(@correction)
    click_on "Destroy this correction", match: :first

    assert_text "Correction was successfully destroyed"
  end
end
