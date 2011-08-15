require 'test_helper'

class WorksheetsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.

  def setup
    @worksheet = worksheets(:monomial_worksheet_01)
  end
  
  test "update/replace changes div content of target problem" do
    assert_problem_changes_on_update(@worksheet, 3)
  end
  
  test "update/replace problem failure should display correct error msg if problem is unique" do
    
    unique_problem = worksheet_problems(:monomial_worksheet_unique_problem)

    assert_problem_does_not_change_on_update(@worksheet, unique_problem.problem_number)
  
    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', MathHotSpotErrors::Message::UNIQUE
  end
  
  test "update/replace error display for no remaining problems of given type" do
    second_problem_of_two_on_worksheet = worksheet_problems(:monomial_worksheet_prob_05)
  
    assert_problem_does_not_change_on_update(@worksheet, second_problem_of_two_on_worksheet.problem_number)  

    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', MathHotSpotErrors::Message::NONE_REMAINING
  end
  
  test "update/replace error display for request replacement of problem that doesn't exist" do    
    nonexistent_problem_number = @worksheet.worksheet_problems.size + 1
    assert_problem_does_not_change_on_update(@worksheet, nonexistent_problem_number)  
  
    assert_response :success
    assert_not_nil assigns(:worksheet)
    assert_select 'div.notice', MathHotSpotErrors::Message::DEFAULT
  end
  
  test "edit worksheet" do
    get(:edit, {:id => @worksheet.id})
    assert_response :success
  end
  
  private
  
  def assert_problem_changes_on_update(worksheet, problem_number)
    compare_problem_before_and_after_update(worksheet, problem_number, false)
  end

  def assert_problem_does_not_change_on_update(worksheet, problem_number)
    compare_problem_before_and_after_update(worksheet, problem_number, true)
  end
  
  def compare_problem_before_and_after_update(worksheet, problem_number, should_be_equal)
    get(:show, {:id => worksheet.id})
    initial_state = css_select("div.worksheet div#problem_#{problem_number}")[0]
    put(:update, {:id => worksheet.id, :problem_number => problem_number})
    after_state = css_select("div.worksheet div#problem_#{problem_number}")[0]
    if (should_be_equal)
      assert_equal initial_state, after_state, "Problem #{problem_number} change after replace call but should have remained unchanged."
    else
      assert_not_equal initial_state, after_state, "Problem #{problem_number} did not change after replace call."
    end
  end
end
