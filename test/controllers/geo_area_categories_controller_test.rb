require 'test_helper'

class GeoAreaCategoriesControllerTest < ActionController::TestCase
  setup do
    @geo_area_category = geo_area_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geo_area_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geo_area_category" do
    assert_difference('GeoAreaCategory.count') do
      post :create, geo_area_category: {  }
    end

    assert_redirected_to geo_area_category_path(assigns(:geo_area_category))
  end

  test "should show geo_area_category" do
    get :show, id: @geo_area_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geo_area_category
    assert_response :success
  end

  test "should update geo_area_category" do
    patch :update, id: @geo_area_category, geo_area_category: {  }
    assert_redirected_to geo_area_category_path(assigns(:geo_area_category))
  end

  test "should destroy geo_area_category" do
    assert_difference('GeoAreaCategory.count', -1) do
      delete :destroy, id: @geo_area_category
    end

    assert_redirected_to geo_area_categories_path
  end
end
