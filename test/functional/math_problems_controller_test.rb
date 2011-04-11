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

  test "should destroy math problem" do
    assert_difference('MathProblem.count', -1) do
      delete :destroy, :id => @math_problem.to_param
    end
  end

  test "should get edit" do
    get :edit, :id => @math_problem.to_param
    assert_response :success
  end

  test "should update math_problem" do
    put :update, :id => @math_problem.to_param, :math_problem => @math_problem.attributes
    assert_redirected_to math_problem_path(assigns(:math_problem))
  end
  
  test "should get grouped" do
    get :grouped
    assert_response :success
    assert_not_nil assigns(:problem_groups)    
  end

  test "should get rougue" do
    get :rougue
    assert_response :success
    assert_not_nil assigns(:rougue_problems)    
  end
end
