require 'test_helper'

class DataControllersControllerTest < ActionController::TestCase
  setup do
    @data_controller = data_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_controller" do
    assert_difference('DataController.count') do
      post :create, data_controller: {  }
    end

    assert_redirected_to data_controller_path(assigns(:data_controller))
  end

  test "should show data_controller" do
    get :show, id: @data_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_controller
    assert_response :success
  end

  test "should update data_controller" do
    patch :update, id: @data_controller, data_controller: {  }
    assert_redirected_to data_controller_path(assigns(:data_controller))
  end

  test "should destroy data_controller" do
    assert_difference('DataController.count', -1) do
      delete :destroy, id: @data_controller
    end

    assert_redirected_to data_controllers_path
  end
end
