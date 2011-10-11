require 'test_helper'

class ProblemLevelsControllerTest < AuthenticatingControllerTestCase
  def setup
  end

  test "should show" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    get :show, :problem_type_id => @problem_level.problem_type.permalink, :id => @problem_level.level_number
    assert_response :success
  end

  test "show should display current worksheet and problem level if current_worksheet specified in session" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    worksheet = worksheets(:monomial_worksheet_01)

    session['current_worksheet_id'] = worksheet.id
    get :show, :problem_type_id => @problem_level.problem_type.permalink, :id => @problem_level.level_number

    assert_response :success
    assert_current_asset_display_in_view
  end
  
  test "show displays problem type title and level number" do
    type = Factory.build(:problem_type)
    type_id = 92834
    level1 = Factory.build(:problem_level, :level_number => 1, :problem_type => type)

    type.stubs(:id).returns(type_id)
    ProblemType.expects(:find_by_permalink).with(type.permalink).returns(type)
    ProblemLevel.expects(:find_by_level_number_and_problem_type_id).with('1', type_id).returns(level1)

    get :show, :problem_type_id => type.to_param, :id => level1.level_number.to_param
        
    assert_response :success
    assert_select "#level-info", "#{type.title}: Level 1"
  end
  
  test "show displays add math problem link only if current worksheet present for problem not yet on worksheet" do
    worksheet = worksheets(:monomial_worksheet_01)
    problem_level = problem_levels(:dividing_monomials_level_01)

    session['current_worksheet_id'] = worksheet.id
    get :show, :problem_type_id => problem_level.problem_type.permalink, :id => problem_level.level_number

    # assumes fixture arrangement: all math problems on problem level are already on worksheet EXCEPT the 2nd math problem
    assert_select ".math-display" do
      assert_select '.math-problem-links' do |links|
        links.each_with_index do |link, index|
          index == 1 ? assert_add_problem_to_worksheet_button_appears(link) : assert_add_problem_to_worksheet_button_does_not_appear(link)
        end
      end
    end
  end
  
  test 'show displays no add math problem links if current lesson displayed' do
    lesson = lessons(:dividing_monomials_lesson)
    problem_level = problem_levels(:dividing_monomials_level_01)

    session['current_lesson_id'] = lesson.id
    get :show, :problem_type_id => problem_level.problem_type.permalink, :id => problem_level.level_number

    assert_add_problem_to_worksheet_button_does_not_appear
  end
  
  test 'show displays no add math problem links if no current asset displayed' do
    problem_level = problem_levels(:dividing_monomials_level_01)

    get :show, :problem_type_id => problem_level.problem_type.permalink, :id => problem_level.level_number

    assert_add_problem_to_worksheet_button_does_not_appear
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

  test "should create problem level and nested math problem" do
    problem_type = problem_types(:empty_problem_type)
    problem_level = ProblemLevel.new(:problem_type => problem_type, :level_number => problem_type.lowest_available_level_number)
    
    assert_difference('MathProblem.count') do
      post :create, :problem_type_id => problem_type.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end
    assert_redirected_to problem_type_path(problem_type)    
  end
  
  test "created problem level belongs to user of parent problem type instead of current user (if different)" do
    sign_in users(:joe)

    problem_type = problem_types(:empty_problem_type)
    problem_level = ProblemLevel.new(:problem_type => problem_type, :level_number => problem_type.lowest_available_level_number)

    post :create, :problem_type_id => problem_type.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)

    assert_equal users(:testuser), assigns(:problem_level).owner
    assert_equal users(:joe), assigns(:problem_level).math_problems.first.owner
  end  

  test "update level number for existing problem level" do
    level = problem_levels(:dividing_monomials_level_03)
    assert_equal 3, level.level_number
    
    put :update, :id => level.level_number, :problem_type_id => level.problem_type.permalink, :problem_level => {:level_number => 40}
    
    assert_redirected_to problem_type_path(level.problem_type)
    assert_equal 40, assigns(:problem_level).level_number
  end
  
  test "new nested math problem should belong to current user" do
    other_user = Factory.create(:user)
    type = Factory.create(:problem_type, :owner => other_user)
    problem_level = ProblemLevel.new(:problem_type => type, :level_number => type.lowest_available_level_number)

    assert_difference('ProblemLevel.count') do
      post :create, :problem_type_id => type.permalink, :problem_level => problem_level.attributes.merge(math_problem_attributes)
    end
    
    assert_equal other_user, assigns(:problem_level).owner, "New Level should belong to owner of parent Problem Type"
    assert_equal 1, assigns(:problem_level).math_problems.count
    new_problem = assigns(:problem_level).math_problems.first

    assert_equal @current_user, new_problem.owner, "Newly created Math Problem should belong to current User"
  end
  
  private

  def math_problem_attributes
    {:math_problems_attributes => {"0" => {:question_markup => 'some question', :answer_markup => 'some answer'}}}    
  end

  def assert_prompts_for_problem_question_and_answer
    assert_select "textarea#question-markup-input", 1    
    assert_select "textarea#answer-markup-input", 1
  end
  
  def assert_add_problem_to_worksheet_button_appears(element = nil)
    assert_add_problem_to_worksheet_button element, true
  end
  
  def assert_add_problem_to_worksheet_button_does_not_appear(element = nil)
    assert_add_problem_to_worksheet_button element, false
  end
  
  def assert_add_problem_to_worksheet_button(element = nil, present = true)
    element.nil? ? assert_select('form#new_worksheet_problem', present) : assert_select(element, 'form#new_worksheet_problem', present)
  end
end
