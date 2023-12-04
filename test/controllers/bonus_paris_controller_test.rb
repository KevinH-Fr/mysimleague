require "test_helper"

class BonusParisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bonus_pari = bonus_paris(:one)
  end

  test "should get index" do
    get bonus_paris_url
    assert_response :success
  end

  test "should get new" do
    get new_bonus_pari_url
    assert_response :success
  end

  test "should create bonus_pari" do
    assert_difference("BonusPari.count") do
      post bonus_paris_url, params: { bonus_pari: { montant: @bonus_pari.montant, user_id: @bonus_pari.user_id } }
    end

    assert_redirected_to bonus_pari_url(BonusPari.last)
  end

  test "should show bonus_pari" do
    get bonus_pari_url(@bonus_pari)
    assert_response :success
  end

  test "should get edit" do
    get edit_bonus_pari_url(@bonus_pari)
    assert_response :success
  end

  test "should update bonus_pari" do
    patch bonus_pari_url(@bonus_pari), params: { bonus_pari: { montant: @bonus_pari.montant, user_id: @bonus_pari.user_id } }
    assert_redirected_to bonus_pari_url(@bonus_pari)
  end

  test "should destroy bonus_pari" do
    assert_difference("BonusPari.count", -1) do
      delete bonus_pari_url(@bonus_pari)
    end

    assert_redirected_to bonus_paris_url
  end
end
