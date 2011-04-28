require 'test_helper'

class MathProblemTemplatesControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    authenticate
  end

  test "show" do
    template = math_problem_templates(:dividing_monomials_template)
    get :show, :id => template.id
    assert_response :success
  end
  
  test "new" do
    @template = template_with_level_and_problem
    get :new
    assert_response :success
    assert_prompts_for_problem_question_and_answer
  end
    
  private
  def template_with_level_and_problem
    template = MathProblemTemplate.new
    level = template.problem_levels.build
    level.math_problems.build
    template
  end

  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#math_problem_template_problem_levels_attributes_0_math_problems_attributes_0_question_markup", 1    
    assert_select "textarea#math_problem_template_problem_levels_attributes_0_math_problems_attributes_0_answer_markup", 1
  end
end
