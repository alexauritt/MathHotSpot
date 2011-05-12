require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  setup do
    authenticate
    @lesson = lessons(:dividing_monomials_lesson)
  end

  test "should show lesson" do
    get :show, {:category_id => @lesson.category.id, :id => @lesson.to_param }
    assert_response :success
  end

end
