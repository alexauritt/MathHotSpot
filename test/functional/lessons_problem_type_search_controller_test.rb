require 'test_helper'

class LessonsProblemTypeSearchControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  
  def setup
    @lesson_id = 666
    @lesson = Factory.build(:lesson)
    @lesson.stubs(:id).returns(@lesson_id)
    Lesson.expects(:find).with(@lesson_id).returns(@lesson)
  end
  
  test "show" do
    get :show, :lesson_id => @lesson_id, :query_string => "booyaa!"
    assert_response :success
  end
  
  test "new" do
    get :new, :lesson_id => @lesson_id
    
    assert assigns(:subjects)
    assert assigns(:tags)
    assert assigns(:current_lesson)
    assert_response :success
  end
end
