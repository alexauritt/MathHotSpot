require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  setup do
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

    assert_redirected_to lesson_path(assigns(:lesson))
  end

  test "should show lesson" do
    get :show, {:subject_id => @lesson.subject.id, :id => @lesson.to_param }
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lesson.to_param
    assert_response :success
  end

  test "should update lesson" do
    put :update, :id => @lesson.to_param, :lesson => @lesson.attributes
    lesson = assigns(:lesson)
    assert_redirected_to subject_lesson_path(lesson.subject, lesson)
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => @lesson.to_param
    end

    assert_redirected_to lessons_path
  end
end
