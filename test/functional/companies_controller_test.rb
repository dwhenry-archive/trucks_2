require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create companies" do
    assert_difference('Companies.count') do
      post :create, :companies => { }
    end

    assert_redirected_to companies_path(assigns(:companies))
  end

  test "should show companies" do
    get :show, :id => companies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => companies(:one).to_param
    assert_response :success
  end

  test "should update companies" do
    put :update, :id => companies(:one).to_param, :companies => { }
    assert_redirected_to companies_path(assigns(:companies))
  end

  test "should destroy companies" do
    assert_difference('Companies.count', -1) do
      delete :destroy, :id => companies(:one).to_param
    end

    assert_redirected_to companies_path
  end
end
