require 'test_helper'

class PoliticalPartiesControllerTest < ActionController::TestCase
  setup do
    @political_party = political_parties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:political_parties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create political_party" do
    assert_difference('PoliticalParty.count') do
      post :create, political_party: { leaning_index: @political_party.leaning_index, name: @political_party.name }
    end

    assert_redirected_to political_party_path(assigns(:political_party))
  end

  test "should show political_party" do
    get :show, id: @political_party
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @political_party
    assert_response :success
  end

  test "should update political_party" do
    patch :update, id: @political_party, political_party: { leaning_index: @political_party.leaning_index, name: @political_party.name }
    assert_redirected_to political_party_path(assigns(:political_party))
  end

  test "should destroy political_party" do
    assert_difference('PoliticalParty.count', -1) do
      delete :destroy, id: @political_party
    end

    assert_redirected_to political_parties_path
  end
end
