require "application_system_test_case"

class PilotesTest < ApplicationSystemTestCase
  setup do
    @pilote = pilotes(:one)
  end

  test "visiting the index" do
    visit pilotes_url
    assert_selector "h1", text: "Pilotes"
  end

  test "should create pilote" do
    visit pilotes_url
    click_on "New pilote"

    fill_in "Nom", with: @pilote.nom
    click_on "Create Pilote"

    assert_text "Pilote was successfully created"
    click_on "Back"
  end

  test "should update Pilote" do
    visit pilote_url(@pilote)
    click_on "Edit this pilote", match: :first

    fill_in "Nom", with: @pilote.nom
    click_on "Update Pilote"

    assert_text "Pilote was successfully updated"
    click_on "Back"
  end

  test "should destroy Pilote" do
    visit pilote_url(@pilote)
    click_on "Destroy this pilote", match: :first

    assert_text "Pilote was successfully destroyed"
  end
end
