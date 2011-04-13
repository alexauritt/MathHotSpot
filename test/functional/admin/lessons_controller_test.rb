require 'test_helper'

class Admin::LessonsControllerTest < ActionController::TestCase
  def setup
    authenticate
    @lesson = lessons(:dividing_monomials_lesson)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lessons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson" do
    assert_difference('Lesson.count') do
      post :create, :lesson => @lesson.attributes
    end

    assert_redirected_to admin_lessons_path
  end

  test "should get edit" do
    get :edit, :id => @lesson.to_param
    assert_response :success
  end

  test "should update lesson" do
    put :update, :id => @lesson.to_param, :lesson => @lesson.attributes
    lesson = assigns(:lesson)
    assert_redirected_to admin_lessons_path
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => @lesson.to_param
    end

    assert_redirected_to admin_lessons_path
  end
end
