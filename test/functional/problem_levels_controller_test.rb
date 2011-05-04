require 'test_helper'

class ProblemLevelsControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  def setup
    authenticate
  end

  test "should show" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    get :show, :id => @problem_level.to_param
    assert_response :success
  end

  test "should new" do
    template = problem_types(:dividing_monomials_template)
    get :new, :problem_type_id => template.id
    assert_response :success
    assert_prompts_for_problem_question_and_answer    
  end
    
  test "should create" do
    template = problem_types(:dividing_monomials_template)
    problem_level = ProblemLevel.new(:problem_type => template)
    assert_difference('ProblemLevel.count') do
      post :create, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end    
    assert_redirected_to problem_type_path(template)
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
