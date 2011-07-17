require 'test_helper'

class Search::ProblemTypesControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
      
  test "index without current_lesson set in session returns simple problem type search" do
    get :index
    
    assert_response :success
    assert assigns(:subjects)
    assert assigns(:tags)
    assert_problem_type_search_displayed_in_view
    assert_current_lesson_displayed_in_view false
  end
  
  test "view displays current lesson when valid current_lesson_id is set in session" do

    lesson = Factory.build(:lesson)
    @controller.stubs(:lesson_path).with(lesson).returns("userpathofsomesort")

    Lesson.expects(:find).with(anything).returns(lesson)

    get :index, {}, authenticated_session_with({'current_lesson_id' => 234})

    assert_response :success
    assert_equal lesson, assigns(:current_lesson), "Current lesson not found as expected"

    assert_current_lesson_displayed_in_view
    assert_problem_type_search_displayed_in_view
  end
  
  test "view displays simple problem type search when invalid current_lesson_id is set in session" do
    invalid_id = 234234
    Lesson.expects(:find).with(invalid_id).raises(ActiveRecord::RecordNotFound)
    get :index, {}, authenticated_session_with({'current_lesson_id' => invalid_id})
  
    assert_response :success

    assert_problem_type_search_displayed_in_view
    assert_current_lesson_displayed_in_view false
  end
  
  test "current_lesson_id catches error when invalid" do
    #assert raised error
    pending "to do"
  end
  
  test "index clears current_lesson_id in session when said id is invalid" do
    assert_nil session[:current_lesson_id]
    pending "to do it"
  end
  
  private  
  def assert_current_lesson_displayed_in_view(present = true)
    assert_select '#lesson-header', present, "This page should NOT contain a #lesson-header"
    assert_select '#current-lesson-short', present, "This page should NOT contain a #current-lesson-short"
  end
  
  def assert_problem_type_search_displayed_in_view(present = true)
    assert_select '#problem-type-search', present
  end
  
end
