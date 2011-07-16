require 'test_helper'

class Search::ProblemTypesControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  test "index without current_lesson set in session returns simple problem type search" do
    get :index
    
    assert_response :success
    assert assigns(:subjects)
    assert assigns(:tags)
    assert_select '#problem-type-search'
    assert_no_current_lesson_displayed_in_view  
  end
  
  private
  def assert_no_current_lesson_displayed_in_view
    assert_select '#lesson-header', false, "This page should NOT contain a #lesson-header"
    assert_select '#current-lesson-short', false, "This page should NOT contain a #current-lesson-short"
  end
end
