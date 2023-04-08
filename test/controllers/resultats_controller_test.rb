require "test_helper"

class ResultatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resultat = resultats(:one)
  end

  test "should get index" do
    get resultats_url
    assert_response :success
  end

  test "should get new" do
    get new_resultat_url
    assert_response :success
  end

  test "should create resultat" do
    assert_difference("Resultat.count") do
      post resultats_url, params: { resultat: { course: @resultat.course, dnf: @resultat.dnf, dns: @resultat.dns, dotd: @resultat.dotd, equipe_id: @resultat.equipe_id, event_id: @resultat.event_id, mt: @resultat.mt, pilote_id: @resultat.pilote_id, qualification: @resultat.qualification, score: @resultat.score } }
    end

    assert_redirected_to resultat_url(Resultat.last)
  end

  test "should show resultat" do
    get resultat_url(@resultat)
    assert_response :success
  end

  test "should get edit" do
    get edit_resultat_url(@resultat)
    assert_response :success
  end

  test "should update resultat" do
    patch resultat_url(@resultat), params: { resultat: { course: @resultat.course, dnf: @resultat.dnf, dns: @resultat.dns, dotd: @resultat.dotd, equipe_id: @resultat.equipe_id, event_id: @resultat.event_id, mt: @resultat.mt, pilote_id: @resultat.pilote_id, qualification: @resultat.qualification, score: @resultat.score } }
    assert_redirected_to resultat_url(@resultat)
  end

  test "should destroy resultat" do
    assert_difference("Resultat.count", -1) do
      delete resultat_url(@resultat)
    end

    assert_redirected_to resultats_url
  end
end
