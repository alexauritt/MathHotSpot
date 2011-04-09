require 'test_helper'

class MathProblemsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    @math_problem = math_problems(:simple_monomial_problem_01)
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("foo:bar")    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problem_groups)
  end
  
  test "should show math problem" do
    get :show, :id => @math_problem.to_param
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create math problem" do
    assert_difference('MathProblem.count') do
      post :create, :math_problem => @math_problem.attributes
    end
    assert_redirected_to math_problem_path(assigns(:math_problem))
  end
end
