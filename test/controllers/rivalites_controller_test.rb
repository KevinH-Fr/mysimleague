require "test_helper"

class RivalitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rivalite = rivalites(:one)
  end

  test "should get index" do
    get rivalites_url
    assert_response :success
  end

  test "should get new" do
    get new_rivalite_url
    assert_response :success
  end

  test "should create rivalite" do
    assert_difference("Rivalite.count") do
      post rivalites_url, params: { rivalite: { division_id: @rivalite.division_id, pilote1_id: @rivalite.pilote1_id, pilote2_id: @rivalite.pilote2_id, statut: @rivalite.statut } }
    end

    assert_redirected_to rivalite_url(Rivalite.last)
  end

  test "should show rivalite" do
    get rivalite_url(@rivalite)
    assert_response :success
  end

  test "should get edit" do
    get edit_rivalite_url(@rivalite)
    assert_response :success
  end

  test "should update rivalite" do
    patch rivalite_url(@rivalite), params: { rivalite: { division_id: @rivalite.division_id, pilote1_id: @rivalite.pilote1_id, pilote2_id: @rivalite.pilote2_id, statut: @rivalite.statut } }
    assert_redirected_to rivalite_url(@rivalite)
  end

  test "should destroy rivalite" do
    assert_difference("Rivalite.count", -1) do
      delete rivalite_url(@rivalite)
    end

    assert_redirected_to rivalites_url
  end
end
