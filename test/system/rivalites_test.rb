require "application_system_test_case"

class RivalitesTest < ApplicationSystemTestCase
  setup do
    @rivalite = rivalites(:one)
  end

  test "visiting the index" do
    visit rivalites_url
    assert_selector "h1", text: "Rivalites"
  end

  test "should create rivalite" do
    visit rivalites_url
    click_on "New rivalite"

    fill_in "Division", with: @rivalite.division_id
    fill_in "Pilote1", with: @rivalite.pilote1_id
    fill_in "Pilote2", with: @rivalite.pilote2_id
    check "Statut" if @rivalite.statut
    click_on "Create Rivalite"

    assert_text "Rivalite was successfully created"
    click_on "Back"
  end

  test "should update Rivalite" do
    visit rivalite_url(@rivalite)
    click_on "Edit this rivalite", match: :first

    fill_in "Division", with: @rivalite.division_id
    fill_in "Pilote1", with: @rivalite.pilote1_id
    fill_in "Pilote2", with: @rivalite.pilote2_id
    check "Statut" if @rivalite.statut
    click_on "Update Rivalite"

    assert_text "Rivalite was successfully updated"
    click_on "Back"
  end

  test "should destroy Rivalite" do
    visit rivalite_url(@rivalite)
    click_on "Destroy this rivalite", match: :first

    assert_text "Rivalite was successfully destroyed"
  end
end
