require 'test_helper'

class GeoAreasControllerTest < ActionController::TestCase
  setup do
    @geo_area = geo_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geo_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geo_area" do
    assert_difference('GeoArea.count') do
      post :create, geo_area: {  }
    end

    assert_redirected_to geo_area_path(assigns(:geo_area))
  end

  test "should show geo_area" do
    get :show, id: @geo_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geo_area
    assert_response :success
  end

  test "should update geo_area" do
    patch :update, id: @geo_area, geo_area: {  }
    assert_redirected_to geo_area_path(assigns(:geo_area))
  end

  test "should destroy geo_area" do
    assert_difference('GeoArea.count', -1) do
      delete :destroy, id: @geo_area
    end

    assert_redirected_to geo_areas_path
  end
end
