require 'test_helper'

class CategoriesControllerTest < AuthenticatingControllerTestCase
  setup do
    @category = categories(:polynomials)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    cat = Category.new(:title => "I am a new Category!")
    assert_difference('Category.count') do
      post :create, :category => cat.attributes
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => @category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @category.to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => @category.to_param, :category => @category.attributes
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    category = categories(:empty_category)
    assert_difference('Category.count', -1) do
      delete :destroy, :id => category.to_param
    end

    assert_redirected_to categories_path
  end
end
