require 'test_helper'

class LoadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loads" do
    assert_difference('Loads.count') do
      post :create, :loads => { }
    end

    assert_redirected_to loads_path(assigns(:loads))
  end

  test "should show loads" do
    get :show, :id => loads(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => loads(:one).to_param
    assert_response :success
  end

  test "should update loads" do
    put :update, :id => loads(:one).to_param, :loads => { }
    assert_redirected_to loads_path(assigns(:loads))
  end

  test "should destroy loads" do
    assert_difference('Loads.count', -1) do
      delete :destroy, :id => loads(:one).to_param
    end

    assert_redirected_to loads_path
  end
end
