require "application_system_test_case"

class SetupsTest < ApplicationSystemTestCase
  setup do
    @setup = setups(:one)
  end

  test "visiting the index" do
    visit setups_url
    assert_selector "h1", text: "Setups"
  end

  test "should create setup" do
    visit setups_url
    click_on "New setup"

    fill_in "Game", with: @setup.game_id
    fill_in "Nom", with: @setup.nom
    click_on "Create Setup"

    assert_text "Setup was successfully created"
    click_on "Back"
  end

  test "should update Setup" do
    visit setup_url(@setup)
    click_on "Edit this setup", match: :first

    fill_in "Game", with: @setup.game_id
    fill_in "Nom", with: @setup.nom
    click_on "Update Setup"

    assert_text "Setup was successfully updated"
    click_on "Back"
  end

  test "should destroy Setup" do
    visit setup_url(@setup)
    click_on "Destroy this setup", match: :first

    assert_text "Setup was successfully destroyed"
  end
end
