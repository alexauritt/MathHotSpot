require 'test_helper'

class ProblemTypesControllerTest < AuthenticatingControllerTestCase
  
  setup do
    @problem_type = Factory.build(:problem_type)
    @lesson = Factory.build(:lesson)
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
  
  test "show should display current lesson and problem type if current_lesson specified in session" do
    lesson, problem_type = stub_db_to_return_lesson_and_problem_type!
    get(:show, {:id => @problem_type.permalink}, authenticated_session_with({'current_lesson_id' => lesson.id}))
      
    assert_equal lesson.id, session[:current_lesson_id]
    assert_response :success
    
    assert_current_lesson_displayed_in_view
  end
    
  test "new" do
    @problem_type = problem_type_with_category_level_and_problem
    get :new
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
  
  test "delete empty problem type" do
    problem_type = problem_types(:empty_problem_type)
    
    assert problem_type.empty?
    assert_difference('ProblemType.count', -1) do
      delete :destroy, :id => problem_type.to_param
    end

    assert_redirected_to root_path
  end
  
  test "delete fails if problem type is not empty" do
    problem_type = problem_types(:dividing_monomials_problem_type)
    
    assert !problem_type.empty?
    assert_no_difference('ProblemType.count') do
      delete :destroy, :id => problem_type.to_param
    end

    assert_redirected_to root_path
  end

  test "create makes new empty problem_type even if level information is incomplete" do
    problem_type = problem_type_with_category_and_incomplete_level
    attributes = problem_type.attributes.merge nested_incomplete_level_attributes
    message = "New ProblemType was not successfully create - probably do to improper formatting of nested ProblemLevel"
    assert_difference('ProblemType.count', 1, message) do
      post :create, :problem_type => attributes
    end
    
    assert_redirected_to problem_type_path(problem_type)

  end
  
  test "does NOT create level if level info incomplete" do
    problem_type = problem_type_with_category_and_incomplete_level
    
    assert_no_difference('ProblemLevel.count') do
      post :create, :problem_type => problem_type.attributes
    end
    
    assert_redirected_to problem_type_url(problem_type)
  end

  test "create makes new problem_type with lesson, level, and problem" do
    problem_type = problem_type_with_category_level_and_problem

    assert_difference('ProblemType.count') do
      post :create, :problem_type => problem_type.attributes
    end
    
    assert_redirected_to problem_type_path(problem_type)
  end

  test "create makes new problem_level" do
    problem_type = problem_type_with_category_level_and_problem
    attributes = problem_type.attributes.merge nested_level_and_problem_attributes
    assert_difference('ProblemLevel.count') do
      post :create, :problem_type => attributes
    end
    
    assert_redirected_to problem_type_path(problem_type)
  end

  test "create makes new math_problem" do
    problem_type = problem_type_with_category_level_and_problem
    attributes = problem_type.attributes.merge nested_level_and_problem_attributes
    assert_difference('MathProblem.count') do
      post :create, :problem_type => attributes
    end
    
    assert_redirected_to problem_type_path(problem_type)
  end
  
  test "newly created problemtype has current user as owner" do
    post :create, :problem_type => problem_type_with_category_and_incomplete_level.attributes
    assert_equal users(:testuser), assigns(:problem_type).owner
  end
  
  test "should show delete link if problem type has no math problems" do
    problem_type = stubbed_empty_problem_type
    
    get :show, :id => problem_type.permalink

    assert_select ".row#delete_problem_type", "Delete Problem Type"
    assert_response :success
  end
  
  test "should NOT show delete link if problem type has problem levels" do
    problem_type = stubbed_empty_problem_type
    level = problem_type.problem_levels.build(:level_number => 3)
    level.problem_type = problem_type

    get :show, :id => problem_type.permalink

    assert_select ".row#delete_problem_type", false
    assert_response :success
  end
    
  private
  
  def stub_db_to_return_lesson_and_problem_type!
    @lesson.stubs(:id).returns(234234)
    Lesson.stubs(:find).with(234234).returns(@lesson)
    ProblemType.stubs(:find_by_permalink).with(@problem_type.permalink).returns(@problem_type)
    [@lesson, @problem_type]
  end
  
  def stubbed_empty_problem_type
    problem_type = ProblemType.new(:title => "goo goo", :permalink => 'goo-goo', :category => Category.new)
    problem_type.stubs(:instruction_text).returns("Do the damn problem!")
    ProblemType.stubs(:find_by_permalink).with('goo-goo').returns(problem_type)
    problem_type
  end

  def nested_level_and_problem_attributes
    { :problem_levels_attributes => [{:level_number => 666, :math_problems_attributes => 
        [{:question_markup => 'some question', :answer_markup => 'some answer'}]}]}  
  end
  
  def nested_incomplete_level_attributes
    { :problem_levels_attributes => [{}]}
  end
  
  def problem_type_with_category_and_incomplete_level
    category = categories(:polynomials)
    problem_type = ProblemType.new(:title => 'brand new lesson', :category => category)
  end
  
  def problem_type_with_category_level_and_problem
    category = categories(:polynomials)
    problem_type = ProblemType.new(:title => "A new kind of problem!", :category => category)
    level = problem_type.problem_levels.build
    problem = level.math_problems.build(:question_markup => 'a question', :answer_markup => 'an answer')
    problem_type
  end
  
  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#problem_type_problem_levels_attributes_0_math_problems_attributes_0_question_markup", 1    
    assert_select "textarea#problem_type_problem_levels_attributes_0_math_problems_attributes_0_answer_markup", 1
  end
end
