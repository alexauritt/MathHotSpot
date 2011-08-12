require 'test_helper'

class ProblemLevelsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.

  def setup
  end

  test "should show" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    get :show, :problem_type_id => @problem_level.problem_type.permalink, :id => @problem_level.level_number
    assert_response :success
  end

  test "should new" do
    prob_type = problem_types(:dividing_monomials_problem_type)
    get :new, :problem_type_id => prob_type.permalink
    assert_response :success
    assert_prompts_for_problem_question_and_answer    
  end
    
  test "should create" do
    template = problem_types(:dividing_monomials_problem_type)
    problem_level = ProblemLevel.new(:problem_type => template, :level_number => template.lowest_available_level_number)
    assert_difference('ProblemLevel.count') do
      post :create, :problem_type_id => template.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end
    assert_redirected_to problem_type_path(template)
  end
  
  test "should NOT create math problem if math problem info included but new level has duplicate level number" do
    template = problem_types(:dividing_monomials_problem_type)
    problem_level = ProblemLevel.new(:problem_type => template, :level_number => template.problem_levels.first.level_number)
    assert_no_difference('ProblemLevel.count') do
      post :create, :problem_type_id => template.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end
    assert_redirected_to problem_type_path(template)    
  end
  
  test "should NOT create MathProblem if no math problem info included in form" do
    template = problem_types(:dividing_monomials_problem_type)
    problem_level = ProblemLevel.new(:problem_type => template)
    assert_no_difference('MathProblem.count') do
      post :create, :problem_level => problem_level.attributes
    end
    assert_redirected_to problem_type_path(template)
  end

  test "should destroy if level has no math problem children" do
    @problem_level = problem_levels(:empty_level)
    assert_difference('ProblemLevel.count', -1) do
      delete :destroy, :problem_type_id => @problem_level.problem_type.permalink, :id => @problem_level.level_number
    end
    
    assert_redirected_to problem_type_url(@problem_level.problem_type.permalink)
  end

  test "should fail to destroy if level has math problem children" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    assert_no_difference('ProblemLevel.count') do
      delete :destroy, :problem_type_id => @problem_level.problem_type.permalink, :id => @problem_level.level_number
    end
    
    assert_redirected_to problem_type_url(@problem_level.problem_type.permalink)
  end
  
  test "should create new level for existing problem type in database that has no problem levels" do
    problem_type = problem_types(:empty_problem_type)
    problem_level = ProblemLevel.new(:problem_type => problem_type, :level_number => problem_type.lowest_available_level_number)
    assert problem_type.problem_levels.empty?, "This Problem Type (fixture) should have no levels or problems at the start"
    
    assert_difference('ProblemLevel.count') do
      post :create, :problem_type_id => problem_type.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end
    assert_redirected_to problem_type_path(problem_type)    
  end

  test "update level number for existing problem level" do
    level = problem_levels(:dividing_monomials_level_03)
    assert_equal 3, level.level_number
    
    put :update, :id => level.level_number, :problem_type_id => level.problem_type.permalink, :problem_level => {:level_number => 40}
    
    assert_redirected_to problem_type_path(level.problem_type)
    assert_equal 40, assigns(:problem_level).level_number
  end
  
  private

  def math_problem_attributes
    {:math_problems_attributes => [{:question_markup => 'some question', :answer_markup => 'some answer'}] }    
  end

  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#problem_level_math_problems_attributes_0_question_markup", 1    
    assert_select "textarea#problem_level_math_problems_attributes_0_answer_markup", 1
  end

end
