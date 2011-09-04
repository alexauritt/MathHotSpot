require 'test_helper'

class LessonWorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  test "new" do
    lesson = lessons(:dividing_monomials_lesson)
    get :new, :id => lesson
    assert_response :success
  end
end
