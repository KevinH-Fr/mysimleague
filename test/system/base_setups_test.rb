require "application_system_test_case"

class BaseSetupsTest < ApplicationSystemTestCase
  setup do
    @base_setup = base_setups(:one)
  end

  test "visiting the index" do
    visit base_setups_url
    assert_selector "h1", text: "Base setups"
  end

  test "should create base setup" do
    visit base_setups_url
    click_on "New base setup"

    fill_in "Explication", with: @base_setup.explication
    fill_in "Parametre", with: @base_setup.parametre
    fill_in "Val max", with: @base_setup.val_max
    fill_in "Val min", with: @base_setup.val_min
    click_on "Create Base setup"

    assert_text "Base setup was successfully created"
    click_on "Back"
  end

  test "should update Base setup" do
    visit base_setup_url(@base_setup)
    click_on "Edit this base setup", match: :first

    fill_in "Explication", with: @base_setup.explication
    fill_in "Parametre", with: @base_setup.parametre
    fill_in "Val max", with: @base_setup.val_max
    fill_in "Val min", with: @base_setup.val_min
    click_on "Update Base setup"

    assert_text "Base setup was successfully updated"
    click_on "Back"
  end

  test "should destroy Base setup" do
    visit base_setup_url(@base_setup)
    click_on "Destroy this base setup", match: :first

    assert_text "Base setup was successfully destroyed"
  end
end
