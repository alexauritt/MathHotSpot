require 'test_helper'

class MyLessonsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  test "index" do
    get :index
    assert_response :success
    assert assigns(:lessons)
    assert_select '#my-lessons'
  end
  
  test "index clears current_lesson_id from session" do
    session['current_lesson_id'] = 234234

    get :index
    
    assert_nil session[:current_lesson_id]
  end
end
