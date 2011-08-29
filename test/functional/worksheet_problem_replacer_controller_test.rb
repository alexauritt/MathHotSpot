require 'test_helper'

class WorksheetProblemReplacerControllerTest < AuthenticatingControllerTestCase
  test "create replaces existing worksheet problem" do
    worksheet = worksheets(:monomial_worksheet_01)
    problem_number_to_swap = 3
    problem_to_swap = worksheet.problem(problem_number_to_swap).math_problem

    post :create, :worksheet_problem_replacer => {:worksheet_id => worksheet.id, :problem_number => problem_number_to_swap}
  
    assert assigns(:worksheet), "Worksheet not assigned to variable in controller"
    replacement_problem = assigns(:worksheet).problem(problem_number_to_swap).math_problem
    
    assert_not_equal problem_to_swap, replacement_problem
    assert problem_to_swap.is_a? MathProblem
  end
end
