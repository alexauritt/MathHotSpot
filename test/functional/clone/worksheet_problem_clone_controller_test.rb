require 'test_helper'

class Clone::WorksheetProblemCloneControllerTest < AuthenticatingControllerTestCase

  def setup
    @worksheet_id = 5
    @problem_number = 2
    @worksheet_problem = Factory.build(:worksheet_problem)
  end
  
  test "new" do
    mock_worksheet_problem!
    get :new, { :worksheet_id => @worksheet_id, :problem_number => @problem_number }
    
    assert_hidden_worksheet_id_input! @worksheet_id
    assert_response :success
  end
  
  test "new for unclassified math problem" do
    @worksheet_problem.math_problem.problem_level = nil
    mock_worksheet_problem!

    get :new, { :worksheet_id => @worksheet_id, :problem_number => @problem_number }
    
    assert_hidden_worksheet_id_input! @worksheet_id
    assert_response :success
  end
  
  private

  def assert_hidden_worksheet_id_input!(worksheet_id)
    assert_select "form input#worksheet_problem_worksheet_id[value=#{worksheet_id}][type=hidden]"
  end
  
  def mock_worksheet_problem!(worksheet_id = @worksheet_id, problem_number = @problem_number)
    @worksheet_problem.worksheet.stubs(:id).returns(@worksheet_id)
    @worksheet_problem.stubs(:problem_number).returns(@problem_number)
    WorksheetProblem.expects(:find_by_worksheet_id_and_problem_number).with(worksheet_id, problem_number).returns(@worksheet_problem)
    @worksheet_problem
  end
  
end
