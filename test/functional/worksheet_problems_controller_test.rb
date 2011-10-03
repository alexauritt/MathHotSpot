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
    new_math_problem = Factory.build(:math_problem, :problem_level_id => problem_level.id)
    new_worksheet_problem = Factory.build(:worksheet_problem, :worksheet_id => worksheet.id)

    assert_difference('WorksheetProblem.count') do
      assert_difference('MathProblem.count') do
        post :create, :worksheet_problem => {:worksheet_id => worksheet.id, :math_problem_attributes => new_math_problem.attributes}
      end
    end
    assert_current_user_is_owner assigns(:worksheet_problem).math_problem
    assert_redirected_to edit_worksheet_path(worksheet)
  end
  
  test "new worksheet problem" do
    worksheet_id = 234345
    worksheet = Factory.build(:worksheet)
    Worksheet.expects(:find).with(worksheet_id).returns(worksheet)

    get :new, :worksheet_id => worksheet_id

    assert_response :success
    assert assigns(:worksheet)
    assert_worksheet_id_specified_but_hidden worksheet_id
    assert_nested_math_problem_form
    
  end
      
  private
  
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
    assert_select "textarea#worksheet_problem_math_problem_question_markup"
    assert_select "textarea#worksheet_problem_math_problem_answer_markup"
  end  
end
