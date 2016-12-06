require 'test_helper'

class ActiveStoreTemplatesControllerTest < ActionController::TestCase
  setup do
    @active_store_template = active_store_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_store_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create active_store_template" do
    assert_difference('ActiveStoreTemplate.count') do
      post :create, active_store_template: {  }
    end

    assert_redirected_to active_store_template_path(assigns(:active_store_template))
  end

  test "should show active_store_template" do
    get :show, id: @active_store_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @active_store_template
    assert_response :success
  end

  test "should update active_store_template" do
    patch :update, id: @active_store_template, active_store_template: {  }
    assert_redirected_to active_store_template_path(assigns(:active_store_template))
  end

  test "should destroy active_store_template" do
    assert_difference('ActiveStoreTemplate.count', -1) do
      delete :destroy, id: @active_store_template
    end

    assert_redirected_to active_store_templates_path
  end
end
