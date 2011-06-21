require 'test_helper'

class ProblemTypesControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    authenticate
  end

  test "index" do
    get :index
    assert_response :success
  end
  
  test "index search" do
    get :index, :search => "Monomial Fraction"
    assert_response :success
    assert assigns(:problem_types).include?(problem_types(:dividing_monomials_problem_type))
  end

  test "show" do
    problem_type = problem_types(:dividing_monomials_problem_type)
    get :show, :id => problem_type.permalink
    assert_response :success
  end
  
  test "new" do
    @problem_type = problem_type_with_lesson_level_and_problem
    get :new, :lesson_id => @problem_type.lesson.id
    assert_response :success
    assert_prompts_for_problem_question_and_answer
  end
  
  test "edit" do
    problem_type = ProblemType.first
    get :edit, :id => problem_type.to_param
    assert_response :success    
  end
  
  test "update" do
    problem_type = ProblemType.first    
    put :update, :id => problem_type.to_param, :problem_type => problem_type.attributes
    assert_redirected_to problem_type_path(assigns(:problem_type))    
  end

  test "lesson_id specified in hidden field in new" do
    problem_type = ProblemType.new
    lesson = lessons(:monomial_factors_of_polynomials_lesson)
    problem_type.lesson = lesson
    get :new, :lesson_id => lesson.id
    assert_select "input#problem_type_lesson_id[type=hidden][value=#{lesson.id}]"
  end

  test "create makes new problem_type" do
    problem_type = problem_type_with_lesson_level_and_problem

    assert_difference('ProblemType.count') do
      post :create, :problem_type => problem_type.attributes
    end
    
    assert_redirected_to lesson_path(problem_type.lesson)
  end

  test "create makes new problem_level" do
    problem_type = problem_type_with_lesson_level_and_problem
    attributes = problem_type.attributes.merge nested_level_and_problem_attributes
    assert_difference('ProblemLevel.count') do
      post :create, :problem_type => attributes
    end
    
    assert_redirected_to lesson_path(problem_type.lesson)
  end

  test "create makes new math_problem" do
    problem_type = problem_type_with_lesson_level_and_problem
    attributes = problem_type.attributes.merge nested_level_and_problem_attributes
    assert_difference('MathProblem.count') do
      post :create, :problem_type => attributes
    end
    
    assert_redirected_to lesson_path(problem_type.lesson)
  end
    
  private

  def nested_level_and_problem_attributes
    { :problem_levels_attributes => [{:level_number => 666, :math_problems_attributes => 
        [{:question_markup => 'some question', :answer_markup => 'some answer'}]}]}  
  end
  
  def problem_type_with_lesson_level_and_problem
    current_lesson = lessons(:monomial_factors_of_polynomials_lesson)
    problem_type = ProblemType.new(:title => "A new kind of problem!")
    problem_type.lesson = current_lesson
    level = problem_type.problem_levels.build
    problem = level.math_problems.build(:question_markup => 'a question', :answer_markup => 'an answer')
    problem_type
  end
  
  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#problem_type_problem_levels_attributes_0_math_problems_attributes_0_question_markup", 1    
    assert_select "textarea#problem_type_problem_levels_attributes_0_math_problems_attributes_0_answer_markup", 1
  end
end
