require 'test_helper'

class WorksheetsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "update/replace problem failure should display correct error msg if problem is unique" do
    worksheet = worksheets(:monomial_worksheet_01)
    unique_problem = worksheet_problems(:monomial_worksheet_unique_problem)

    put(:update, {:id => worksheet.id, :problem_number => unique_problem.problem_number })

    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'p.notice', MathHotSpotErrors::Message::UNIQUE
  end
  
  test "update/replace error display for no remaining problems of given type" do
    worksheet = worksheets(:monomial_worksheet_01)
    second_problem_of_two_on_worksheet = worksheet_problems(:monomial_worksheet_prob_05)

    put(:update, {:id => worksheet.id, :problem_number => second_problem_of_two_on_worksheet.problem_number })

    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'p.notice', MathHotSpotErrors::Message::NONE_REMAINING
  end

  test "update/replace error display for request replacement of problem that doesn't exist" do
    worksheet = worksheets(:monomial_worksheet_01)

    put(:update, {:id => worksheet.id, :problem_number => worksheet.worksheet_problems.size + 1 })

    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'p.notice', MathHotSpotErrors::Message::DEFAULT
  end

end
