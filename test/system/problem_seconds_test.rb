require "application_system_test_case"

class ProblemSecondsTest < ApplicationSystemTestCase
  setup do
    @problem_second = problem_seconds(:one)
  end

  test "visiting the index" do
    visit problem_seconds_url
    assert_selector "h1", text: "Problem seconds"
  end

  test "should create problem second" do
    visit problem_seconds_url
    click_on "New problem second"

    fill_in "Nom", with: @problem_second.nom
    click_on "Create Problem second"

    assert_text "Problem second was successfully created"
    click_on "Back"
  end

  test "should update Problem second" do
    visit problem_second_url(@problem_second)
    click_on "Edit this problem second", match: :first

    fill_in "Nom", with: @problem_second.nom
    click_on "Update Problem second"

    assert_text "Problem second was successfully updated"
    click_on "Back"
  end

  test "should destroy Problem second" do
    visit problem_second_url(@problem_second)
    click_on "Destroy this problem second", match: :first

    assert_text "Problem second was successfully destroyed"
  end
end
