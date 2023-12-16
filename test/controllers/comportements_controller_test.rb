require "test_helper"

class ComportementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comportement = comportements(:one)
  end

  test "should get index" do
    get comportements_url
    assert_response :success
  end

  test "should get new" do
    get new_comportement_url
    assert_response :success
  end

  test "should create comportement" do
    assert_difference("Comportement.count") do
      post comportements_url, params: { comportement: { label_categorie: @comportement.label_categorie, nom: @comportement.nom, principal: @comportement.principal } }
    end

    assert_redirected_to comportement_url(Comportement.last)
  end

  test "should show comportement" do
    get comportement_url(@comportement)
    assert_response :success
  end

  test "should get edit" do
    get edit_comportement_url(@comportement)
    assert_response :success
  end

  test "should update comportement" do
    patch comportement_url(@comportement), params: { comportement: { label_categorie: @comportement.label_categorie, nom: @comportement.nom, principal: @comportement.principal } }
    assert_redirected_to comportement_url(@comportement)
  end

  test "should destroy comportement" do
    assert_difference("Comportement.count", -1) do
      delete comportement_url(@comportement)
    end

    assert_redirected_to comportements_url
  end
end
