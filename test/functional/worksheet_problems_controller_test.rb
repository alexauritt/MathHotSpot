require 'test_helper'

class WorksheetProblemsControllerTest < AuthenticatingControllerTestCase
  test "should destroy worksheet problem" do
    worksheet_problem = worksheet_problems(:monomial_worksheet_prob_01)
    worksheet = worksheet_problem.worksheet
    assert_difference('WorksheetProblem.count', -1) do
      delete :destroy, :id => worksheet_problem
    end
    
    assert_redirected_to edit_worksheet_path(worksheet)
  end
  
  test "create should redirect to worksheet containing new problem" do
    worksheet = stubbed_worksheet
    problem_level = stubbed_problem_level
    new_math_problem = Factory.build(:math_problem, :problem_level_id => problem_level.id, :owner_id => nil)
    new_worksheet_problem = Factory.build(:worksheet_problem, :worksheet_id => worksheet.id)

    assert_difference('WorksheetProblem.count') do
      assert_difference('MathProblem.count') do
        post :create, :worksheet_problem => {:worksheet_id => worksheet.id, :math_problem_attributes => new_math_problem.attributes}
      end
    end
    assert_redirected_to edit_worksheet_path(worksheet)
  end

  test "owner of nested math problems is set to current user" do
    worksheet = stubbed_worksheet
    problem_level = stubbed_problem_level
    new_math_problem = Factory.build(:math_problem, :problem_level_id => problem_level.id, :owner_id => nil)
    new_worksheet_problem = Factory.build(:worksheet_problem, :worksheet_id => worksheet.id)

    post :create, :worksheet_problem => {:worksheet_id => worksheet.id, :math_problem_attributes => new_math_problem.attributes}
    
    assert_current_user_is_owner assigns(:worksheet_problem).math_problem
  end
  
  test "previous owner of math problems retains ownership when different user adds the problem to a worksheet" do
    worksheet = stubbed_worksheet
    problem_level = stubbed_problem_level
    other_user = Factory.create :user
    new_math_problem = Factory.create(:math_problem, :problem_level_id => problem_level.id, :owner_id => other_user.id)

    post :create, :worksheet_problem => {:worksheet_id => worksheet.id, :math_problem_id => new_math_problem.id}
    
    assert_equal other_user, assigns(:worksheet_problem).math_problem.owner
  end
  
  test "new worksheet problem" do
    worksheet_id = 234345.to_param
    mock_worksheet_for_id worksheet_id
    
    get :new, { :worksheet_id => worksheet_id }
    
    assert_response :success
    assert assigns(:worksheet)
    assert_worksheet_id_specified_but_hidden worksheet_id
    assert_nested_math_problem_form
  end
  
  test "current sibling worksheet problems displayed on new worksheet problem form" do
    worksheet_id = 234345.to_param
    worksheet = mock_worksheet_for_id worksheet_id
    5.times do 
      mp = Factory.build(:math_problem)
      worksheet.worksheet_problems.build(:math_problem => mp, :problem_number => worksheet.next_available_problem_number)
    end
    
    get :new, :worksheet_id => worksheet_id
    assert_select "#sibling-problems .worksheet-problem", 5
  end

  private
  
  def mock_worksheet_for_id(id)
    worksheet = Factory.build(:worksheet)
    Worksheet.expects(:find).with(id).returns(worksheet)
    worksheet
  end
  
  def assert_current_user_is_owner(object)
    assert_equal @current_user, object.owner
  end
  
  def stubbed_worksheet
    worksheet_id = 234
    worksheet = Factory.build(:worksheet)
    worksheet.stubs(:id).returns(worksheet_id)
    Worksheet.stubs(:find).returns(worksheet)
    Worksheet.stubs(:exists?).with(worksheet_id).returns(true)
    worksheet
  end
  
  def stubbed_problem_level
    problem_level_id = 234234
    level = Factory.build(:problem_level)
    level.stubs(:id).returns(problem_level_id)
    ProblemLevel.stubs(:find).returns(level)
    ProblemLevel.stubs(:exists?).with(problem_level_id).returns(true)
    level
  end
  
  def assert_worksheet_id_specified_but_hidden(worksheet_id)
    assert_select "#worksheet_problem_worksheet_id", {:type => "hidden", :value => worksheet_id}
  end
  
  def assert_nested_math_problem_form
    assert_select "textarea#question-markup-input"
    assert_select "textarea#answer-markup-input"
  end  
end
