require 'test_helper'

class WorksheetProblemAdderControllerTest < AuthenticatingControllerTestCase
  test "create delegates to Worksheet add_problem_like" do
    worksheet_id = 6666
    problem_number = 3
    
    worksheet = Factory.build(:worksheet)
    worksheet.expects(:add_problem_like!).with(problem_number).returns(true)
    Worksheet.expects(:find).with(worksheet_id).returns(worksheet)
    
    post :create, :worksheet_problem_adder => {:worksheet_id => worksheet_id, :problem_number => problem_number}
    
    assert_response :success
  end
end
