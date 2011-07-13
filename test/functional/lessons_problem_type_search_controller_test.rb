require 'test_helper'

class LessonsProblemTypeSearchControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  test "show" do
    get :show, :lesson_id => 432, :query_string => "booyaa!"
    assert_response :success
  end
end
