require "application_system_test_case"

class ComportementBaseSetupsTest < ApplicationSystemTestCase
  setup do
    @comportement_base_setup = comportement_base_setups(:one)
  end

  test "visiting the index" do
    visit comportement_base_setups_url
    assert_selector "h1", text: "Comportement base setups"
  end

  test "should create comportement base setup" do
    visit comportement_base_setups_url
    click_on "New comportement base setup"

    fill_in "Base setup", with: @comportement_base_setup.base_setup_id
    fill_in "Comportement", with: @comportement_base_setup.comportement_id
    fill_in "Sens", with: @comportement_base_setup.sens
    click_on "Create Comportement base setup"

    assert_text "Comportement base setup was successfully created"
    click_on "Back"
  end

  test "should update Comportement base setup" do
    visit comportement_base_setup_url(@comportement_base_setup)
    click_on "Edit this comportement base setup", match: :first

    fill_in "Base setup", with: @comportement_base_setup.base_setup_id
    fill_in "Comportement", with: @comportement_base_setup.comportement_id
    fill_in "Sens", with: @comportement_base_setup.sens
    click_on "Update Comportement base setup"

    assert_text "Comportement base setup was successfully updated"
    click_on "Back"
  end

  test "should destroy Comportement base setup" do
    visit comportement_base_setup_url(@comportement_base_setup)
    click_on "Destroy this comportement base setup", match: :first

    assert_text "Comportement base setup was successfully destroyed"
  end
end
