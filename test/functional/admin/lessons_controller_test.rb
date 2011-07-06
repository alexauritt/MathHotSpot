require 'test_helper'

class Admin::LessonsControllerTest < AuthenticatingControllerTestCase
  def setup    
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

  test "should get edit" do
    get :edit, :id => @lesson.to_param
    assert_response :success
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => @lesson.to_param
    end

    assert_redirected_to admin_lessons_path
  end
end
