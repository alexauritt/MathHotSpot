require 'test_helper'

class WorksheetProblemReplacerControllerTest < AuthenticatingControllerTestCase
  include RightRabbitErrors
  
  def setup
    @worksheet = worksheets(:monomial_worksheet_01)
  end
  
  test "create replaces existing worksheet problem" do
    problem_number_to_swap = 3
    problem_to_swap = @worksheet.problem(problem_number_to_swap).math_problem

    post :create, :worksheet_problem_replacer => {:worksheet_id => @worksheet.id, :problem_number => problem_number_to_swap}
  
    assert assigns(:worksheet), "Worksheet not assigned to variable in controller"
    replacement_problem = assigns(:worksheet).problem(problem_number_to_swap).math_problem
    
    assert_not_equal problem_to_swap, replacement_problem
    assert problem_to_swap.is_a? MathProblem
  end
  
  test "update/replace problem failure should display correct error msg if problem is unique" do
    
    unique_problem = worksheet_problems(:monomial_worksheet_unique_problem)
    post :create, :worksheet_problem_replacer => {:worksheet_id => @worksheet.id, :problem_number => unique_problem.problem_number}
        
    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', UNIQUE_PROBLEM_ERROR
  end
  
  test "update/replace error display for no remaining problems of given type" do
    second_problem_of_two_on_worksheet = worksheet_problems(:monomial_worksheet_prob_05)
    post :create, :worksheet_problem_replacer => {:worksheet_id => @worksheet.id, :problem_number => second_problem_of_two_on_worksheet.problem_number}
    
    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', NO_SIMILAR_PROBLEMS_REMAINING_MSG
  end
  
  test "update/replace error display for request replacement of problem that doesn't exist" do    
    nonexistent_problem_number = @worksheet.worksheet_problems.size + 1
    post :create, :worksheet_problem_replacer => {:worksheet_id => @worksheet.id, :problem_number => nonexistent_problem_number}
      
    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', MathHotSpotErrors::Message::DEFAULT
  end  
end
