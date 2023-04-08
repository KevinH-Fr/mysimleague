require "application_system_test_case"

class ResultatsTest < ApplicationSystemTestCase
  setup do
    @resultat = resultats(:one)
  end

  test "visiting the index" do
    visit resultats_url
    assert_selector "h1", text: "Resultats"
  end

  test "should create resultat" do
    visit resultats_url
    click_on "New resultat"

    fill_in "Course", with: @resultat.course
    check "Dnf" if @resultat.dnf
    check "Dns" if @resultat.dns
    check "Dotd" if @resultat.dotd
    fill_in "Equipe", with: @resultat.equipe_id
    fill_in "Event", with: @resultat.event_id
    check "Mt" if @resultat.mt
    fill_in "Pilote", with: @resultat.pilote_id
    fill_in "Qualification", with: @resultat.qualification
    fill_in "Score", with: @resultat.score
    click_on "Create Resultat"

    assert_text "Resultat was successfully created"
    click_on "Back"
  end

  test "should update Resultat" do
    visit resultat_url(@resultat)
    click_on "Edit this resultat", match: :first

    fill_in "Course", with: @resultat.course
    check "Dnf" if @resultat.dnf
    check "Dns" if @resultat.dns
    check "Dotd" if @resultat.dotd
    fill_in "Equipe", with: @resultat.equipe_id
    fill_in "Event", with: @resultat.event_id
    check "Mt" if @resultat.mt
    fill_in "Pilote", with: @resultat.pilote_id
    fill_in "Qualification", with: @resultat.qualification
    fill_in "Score", with: @resultat.score
    click_on "Update Resultat"

    assert_text "Resultat was successfully updated"
    click_on "Back"
  end

  test "should destroy Resultat" do
    visit resultat_url(@resultat)
    click_on "Destroy this resultat", match: :first

    assert_text "Resultat was successfully destroyed"
  end
end
