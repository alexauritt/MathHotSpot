require 'test_helper'

class Clone::MathProblemCloneControllerTest < AuthenticatingControllerTestCase
  test "new" do
    parent = math_problems(:simple_monomial_problem_04)
    get :new, :math_problem_id => parent.id
    assert_not_nil assigns(:math_problem)
    assert_response :success
  end
end
