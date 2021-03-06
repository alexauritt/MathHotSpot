require 'test_helper'

class MathProblemsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  def setup
    @math_problem = math_problems(:simple_monomial_problem_01)
  end
    
  test "should show math problem" do
    get :show, :id => @math_problem.to_param
    assert_response :success
  end
  
  test "should get new math problem for existing problem level" do
    level = problem_levels(:dividing_monomials_level_01)
    get :new, :problem_level_id => level.level_number, :problem_type_id => level.problem_type.permalink
    assert_not_nil assigns(:problem_type)
    assert_response :success
  end
  
  test "new find correct problem level and problem type" do
    level = problem_levels(:dividing_monomials_level_01)
    get :new, :problem_level_id => level.level_number, :problem_type_id => level.problem_type.permalink
    assert_equal level.problem_type, assigns(:problem_type)
  end
  
  test "should create math problem for existent and non-empty level" do
    level = problem_levels(:dividing_monomials_level_01)
    problem_attrs = Factory.attributes_for(:math_problem, :problem_level_id => level.id)
    assert_difference('MathProblem.count') do
      post :create, :math_problem => problem_attrs
    end
    assert_redirected_to math_problem_path(assigns(:math_problem))
  end

  test "should create new math problem for existent but empty problem level" do
    type = problem_types(:find_gcf_of_monomials_problem_type)
    new_level = ProblemLevel.create(:problem_type => type, :level_number => type.lowest_available_level_number)
    
    assert_difference('MathProblem.count') do
      post :create, :math_problem => Factory.attributes_for(:math_problem, :problem_level_id => new_level.id)
    end
    
    assert_redirected_to math_problem_path(assigns(:math_problem))
  end
    
  test "should destroy math problem" do
    assert_difference('MathProblem.count', -1) do
      delete :destroy, :id => @math_problem.to_param
    end
  end

  test "should get edit" do
    get :edit, :id => @math_problem.to_param
    assert_not_nil assigns(:problem_type)
    assert_response :success
  end

  test "should update math_problem" do
    put :update, :id => @math_problem.to_param, :math_problem => @math_problem.attributes
    assert_redirected_to math_problem_path(assigns(:math_problem))
  end
  
end
