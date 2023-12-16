require "application_system_test_case"

class ParametreSetupsTest < ApplicationSystemTestCase
  setup do
    @parametre_setup = parametre_setups(:one)
  end

  test "visiting the index" do
    visit parametre_setups_url
    assert_selector "h1", text: "Parametre setups"
  end

  test "should create parametre setup" do
    visit parametre_setups_url
    click_on "New parametre setup"

    fill_in "Base setup", with: @parametre_setup.base_setup_id
    check "Filled" if @parametre_setup.filled
    fill_in "Setup", with: @parametre_setup.setup_id
    fill_in "Val parametre", with: @parametre_setup.val_parametre
    click_on "Create Parametre setup"

    assert_text "Parametre setup was successfully created"
    click_on "Back"
  end

  test "should update Parametre setup" do
    visit parametre_setup_url(@parametre_setup)
    click_on "Edit this parametre setup", match: :first

    fill_in "Base setup", with: @parametre_setup.base_setup_id
    check "Filled" if @parametre_setup.filled
    fill_in "Setup", with: @parametre_setup.setup_id
    fill_in "Val parametre", with: @parametre_setup.val_parametre
    click_on "Update Parametre setup"

    assert_text "Parametre setup was successfully updated"
    click_on "Back"
  end

  test "should destroy Parametre setup" do
    visit parametre_setup_url(@parametre_setup)
    click_on "Destroy this parametre setup", match: :first

    assert_text "Parametre setup was successfully destroyed"
  end
end
