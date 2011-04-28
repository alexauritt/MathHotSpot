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
    @template = template_with_lesson_level_and_problem
    get :new
    assert_response :success
    assert_prompts_for_problem_question_and_answer
  end

  test "create makes new template" do
    template = template_with_lesson_level_and_problem

    assert_difference('MathProblemTemplate.count') do
      post :create, :math_problem_template => template.attributes
    end
    
    assert_redirected_to lesson_path(template.lesson)
  end

  test "create makes new problem_level" do
    template = template_with_lesson_level_and_problem
    attributes = template.attributes.merge nested_level_and_problem_attributes
    assert_difference('ProblemLevel.count') do
      post :create, :math_problem_template => attributes
    end
    
    assert_redirected_to lesson_path(template.lesson)
  end

  test "create makes new math_problem" do
    template = template_with_lesson_level_and_problem
    attributes = template.attributes.merge nested_level_and_problem_attributes
    assert_difference('MathProblem.count') do
      post :create, :math_problem_template => attributes
    end
    
    assert_redirected_to lesson_path(template.lesson)

  end
    
  private

  def nested_level_and_problem_attributes
    { 
      :problem_levels_attributes => [{:math_problems_attributes => 
        [{:question_markup => 'some question', :answer_markup => 'some answer'}]
      }]
    }  
  end
  
  def template_with_lesson_level_and_problem
    current_lesson = lessons(:monomial_factors_of_polynomials_lesson)
    template = MathProblemTemplate.new
    template.lesson = current_lesson
    level = template.problem_levels.build
    problem = level.math_problems.build
    problem.question_markup = "some markup"
    template
  end
  
  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#math_problem_template_problem_levels_attributes_0_math_problems_attributes_0_question_markup", 1    
    assert_select "textarea#math_problem_template_problem_levels_attributes_0_math_problems_attributes_0_answer_markup", 1
  end
end
