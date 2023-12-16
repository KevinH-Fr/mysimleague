require "test_helper"

class ProblemSecondsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @problem_second = problem_seconds(:one)
  end

  test "should get index" do
    get problem_seconds_url
    assert_response :success
  end

  test "should get new" do
    get new_problem_second_url
    assert_response :success
  end

  test "should create problem_second" do
    assert_difference("ProblemSecond.count") do
      post problem_seconds_url, params: { problem_second: { nom: @problem_second.nom } }
    end

    assert_redirected_to problem_second_url(ProblemSecond.last)
  end

  test "should show problem_second" do
    get problem_second_url(@problem_second)
    assert_response :success
  end

  test "should get edit" do
    get edit_problem_second_url(@problem_second)
    assert_response :success
  end

  test "should update problem_second" do
    patch problem_second_url(@problem_second), params: { problem_second: { nom: @problem_second.nom } }
    assert_redirected_to problem_second_url(@problem_second)
  end

  test "should destroy problem_second" do
    assert_difference("ProblemSecond.count", -1) do
      delete problem_second_url(@problem_second)
    end

    assert_redirected_to problem_seconds_url
  end
end
