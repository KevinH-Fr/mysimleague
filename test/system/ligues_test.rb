require "application_system_test_case"

class LiguesTest < ApplicationSystemTestCase
  setup do
    @ligue = ligues(:one)
  end

  test "visiting the index" do
    visit ligues_url
    assert_selector "h1", text: "Ligues"
  end

  test "should create ligue" do
    visit ligues_url
    click_on "New ligue"

    fill_in "Description", with: @ligue.description
    fill_in "Nom", with: @ligue.nom
    click_on "Create Ligue"

    assert_text "Ligue was successfully created"
    click_on "Back"
  end

  test "should update Ligue" do
    visit ligue_url(@ligue)
    click_on "Edit this ligue", match: :first

    fill_in "Description", with: @ligue.description
    fill_in "Nom", with: @ligue.nom
    click_on "Update Ligue"

    assert_text "Ligue was successfully updated"
    click_on "Back"
  end

  test "should destroy Ligue" do
    visit ligue_url(@ligue)
    click_on "Destroy this ligue", match: :first

    assert_text "Ligue was successfully destroyed"
  end
end
