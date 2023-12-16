require "test_helper"

class CorrectifsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @correctif = correctifs(:one)
  end

  test "should get index" do
    get correctifs_url
    assert_response :success
  end

  test "should get new" do
    get new_correctif_url
    assert_response :success
  end

  test "should create correctif" do
    assert_difference("Correctif.count") do
      post correctifs_url, params: { correctif: { base_setup_id: @correctif.base_setup_id, nom: @correctif.nom, problem_id: @correctif.problem_id, problem_second_id: @correctif.problem_second_id, sens: @correctif.sens, setup_id: @correctif.setup_id } }
    end

    assert_redirected_to correctif_url(Correctif.last)
  end

  test "should show correctif" do
    get correctif_url(@correctif)
    assert_response :success
  end

  test "should get edit" do
    get edit_correctif_url(@correctif)
    assert_response :success
  end

  test "should update correctif" do
    patch correctif_url(@correctif), params: { correctif: { base_setup_id: @correctif.base_setup_id, nom: @correctif.nom, problem_id: @correctif.problem_id, problem_second_id: @correctif.problem_second_id, sens: @correctif.sens, setup_id: @correctif.setup_id } }
    assert_redirected_to correctif_url(@correctif)
  end

  test "should destroy correctif" do
    assert_difference("Correctif.count", -1) do
      delete correctif_url(@correctif)
    end

    assert_redirected_to correctifs_url
  end
end
