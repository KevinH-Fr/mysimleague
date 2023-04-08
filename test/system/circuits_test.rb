require "application_system_test_case"

class CircuitsTest < ApplicationSystemTestCase
  setup do
    @circuit = circuits(:one)
  end

  test "visiting the index" do
    visit circuits_url
    assert_selector "h1", text: "Circuits"
  end

  test "should create circuit" do
    visit circuits_url
    click_on "New circuit"

    fill_in "Adresse", with: @circuit.adresse
    fill_in "Latitude", with: @circuit.latitude
    fill_in "Longitude", with: @circuit.longitude
    fill_in "Nom", with: @circuit.nom
    fill_in "Pays", with: @circuit.pays
    click_on "Create Circuit"

    assert_text "Circuit was successfully created"
    click_on "Back"
  end

  test "should update Circuit" do
    visit circuit_url(@circuit)
    click_on "Edit this circuit", match: :first

    fill_in "Adresse", with: @circuit.adresse
    fill_in "Latitude", with: @circuit.latitude
    fill_in "Longitude", with: @circuit.longitude
    fill_in "Nom", with: @circuit.nom
    fill_in "Pays", with: @circuit.pays
    click_on "Update Circuit"

    assert_text "Circuit was successfully updated"
    click_on "Back"
  end

  test "should destroy Circuit" do
    visit circuit_url(@circuit)
    click_on "Destroy this circuit", match: :first

    assert_text "Circuit was successfully destroyed"
  end
end
