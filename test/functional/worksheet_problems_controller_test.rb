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
end
