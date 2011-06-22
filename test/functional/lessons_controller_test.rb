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
  
  test "should display empty problem type message if lesson contains a problem type with no levels" do
    Lesson.any_instance.stubs(:problem_types).returns([ProblemType.new(:permalink => "empty-problem-type", :title => "Empty Problem Type", :instruction => Instruction.new(:description => "blah blah"))])
    get :show, {:category_id => @lesson.category.id, :id => @lesson.to_param }
    assert_response :success
    assert_select "p.inline_math", MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE
  end

end
