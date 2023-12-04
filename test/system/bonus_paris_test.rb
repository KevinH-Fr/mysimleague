require "application_system_test_case"

class BonusParisTest < ApplicationSystemTestCase
  setup do
    @bonus_pari = bonus_paris(:one)
  end

  test "visiting the index" do
    visit bonus_paris_url
    assert_selector "h1", text: "Bonus paris"
  end

  test "should create bonus pari" do
    visit bonus_paris_url
    click_on "New bonus pari"

    fill_in "Montant", with: @bonus_pari.montant
    fill_in "User", with: @bonus_pari.user_id
    click_on "Create Bonus pari"

    assert_text "Bonus pari was successfully created"
    click_on "Back"
  end

  test "should update Bonus pari" do
    visit bonus_pari_url(@bonus_pari)
    click_on "Edit this bonus pari", match: :first

    fill_in "Montant", with: @bonus_pari.montant
    fill_in "User", with: @bonus_pari.user_id
    click_on "Update Bonus pari"

    assert_text "Bonus pari was successfully updated"
    click_on "Back"
  end

  test "should destroy Bonus pari" do
    visit bonus_pari_url(@bonus_pari)
    click_on "Destroy this bonus pari", match: :first

    assert_text "Bonus pari was successfully destroyed"
  end
end
