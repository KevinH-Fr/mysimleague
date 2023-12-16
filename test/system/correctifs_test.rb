require "application_system_test_case"

class CorrectifsTest < ApplicationSystemTestCase
  setup do
    @correctif = correctifs(:one)
  end

  test "visiting the index" do
    visit correctifs_url
    assert_selector "h1", text: "Correctifs"
  end

  test "should create correctif" do
    visit correctifs_url
    click_on "New correctif"

    fill_in "Base setup", with: @correctif.base_setup_id
    fill_in "Nom", with: @correctif.nom
    fill_in "Problem", with: @correctif.problem_id
    fill_in "Problem second", with: @correctif.problem_second_id
    fill_in "Sens", with: @correctif.sens
    fill_in "Setup", with: @correctif.setup_id
    click_on "Create Correctif"

    assert_text "Correctif was successfully created"
    click_on "Back"
  end

  test "should update Correctif" do
    visit correctif_url(@correctif)
    click_on "Edit this correctif", match: :first

    fill_in "Base setup", with: @correctif.base_setup_id
    fill_in "Nom", with: @correctif.nom
    fill_in "Problem", with: @correctif.problem_id
    fill_in "Problem second", with: @correctif.problem_second_id
    fill_in "Sens", with: @correctif.sens
    fill_in "Setup", with: @correctif.setup_id
    click_on "Update Correctif"

    assert_text "Correctif was successfully updated"
    click_on "Back"
  end

  test "should destroy Correctif" do
    visit correctif_url(@correctif)
    click_on "Destroy this correctif", match: :first

    assert_text "Correctif was successfully destroyed"
  end
end
