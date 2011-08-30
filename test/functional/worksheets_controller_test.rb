require 'test_helper'

class WorksheetsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.

  def setup
    @worksheet = worksheets(:monomial_worksheet_01)
  end
  
  test "create empty worksheet with title only" do
    assert_difference('Worksheet.count') do
      post :create, :worksheet => {:title => "Best worksheet Ever"}
    end
    assert_redirected_to worksheet_path(assigns(:worksheet))
  end
  
  test "update/replace changes div content of target problem" do
    assert_problem_changes_on_update(@worksheet, 3)
  end
  
  test "show worksheet" do
    get(:show, {:id => @worksheet.id})
    assert_select '.problem_links input#replace_problem_submit_1', false, "Replace problem should not be present for Worksheet#show -- only Worksheet#update"
    assert_response :success
  end
  
  test "show worksheet does not display solutions" do
    get(:show, {:id => @worksheet.id})
    assert_select '.worksheet-problem .math_display .answer', false, "Solution should not be displayed for Worksheet#show"
  end
  
  test "edit worksheet" do
    get(:edit, {:id => @worksheet.id})
    assert_select '.problem_links input#replace_problem_submit_1'
    assert_response :success
  end
  
  test "destroy worksheet" do
    assert_difference('Worksheet.count', -1) do
      delete :destroy, :id => @worksheet
    end
    assert_redirected_to dashboard_path    
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
