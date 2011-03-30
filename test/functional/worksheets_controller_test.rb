require 'test_helper'

class WorksheetsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "update/replace problem failure should display correct error if problem is unique" do
    worksheet = worksheets(:monomial_worksheet_01)
    unique_problem = worksheet_problems(:monomial_worksheet_unique_problem)

    put(:update, {:id => worksheet.id, :problem_number => unique_problem.problem_number })

    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'p.notice', MathHotSpotErrors::Message::UNIQUE
  end
end
