require 'test_helper'

class ProblemTypes::SearchControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  test "index without current_lesson set in session returns simple problem type search" do
    get :new
    
    assert_response :success
    assert assigns(:subjects)
    assert assigns(:tags)
    assert_problem_type_search_displayed_in_view
    assert_current_lesson_displayed_in_view false
  end

  test "view displays current lesson when valid current_lesson_id is set in session" do
    lesson = Factory.build(:lesson, :id => 234234)
    Lesson.expects(:find).with(anything).returns(lesson)
    
    get :new, {}, authenticated_session_with({'current_lesson_id' => lesson.id})
    
    assert_response :success
    assert_equal lesson, assigns(:current_lesson), "Current lesson not found as expected"
    
    assert_current_lesson_displayed_in_view
    assert_problem_type_search_displayed_in_view
  end
  
  test "view displays simple problem type search when invalid current_lesson_id is set in session" do
    get_new_search_with_invalid_current_lesson_id_in_session!
      
    assert_response :success
    assert_problem_type_search_displayed_in_view
    assert_current_lesson_displayed_in_view false
  end
  
  test "current_lesson_id catches error when invalid" do
    assert_nothing_raised do
      get_new_search_with_invalid_current_lesson_id_in_session!
    end
  end
  
  test "index clears current_lesson_id in session when said id is invalid" do
    get_new_search_with_invalid_current_lesson_id_in_session!
    assert_nil session[:current_lesson_id]
  end
  
  private  

  def get_new_search_with_invalid_current_lesson_id_in_session!
    invalid_id = 234234
    Lesson.expects(:find).with(invalid_id).raises(ActiveRecord::RecordNotFound)
    get :new, {}, authenticated_session_with({'current_lesson_id' => invalid_id})
  end
  
end
