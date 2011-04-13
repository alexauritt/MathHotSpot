require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  setup do
    authenticate
    @lesson = lessons(:dividing_monomials_lesson)
  end

  test "should show lesson" do
    get :show, {:subject_id => @lesson.subject.id, :id => @lesson.to_param }
    assert_response :success
  end

end
