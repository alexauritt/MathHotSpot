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
    
  test "show worksheet" do
    get(:show, {:id => @worksheet.id})
    assert_select '.problem_links input#replace-problem-submit-1', false, "Replace problem should not be present for Worksheet#show -- only Worksheet#update"
    assert_response :success
  end
  
  test "show worksheet does not display solutions" do
    get(:show, {:id => @worksheet.id})
    assert_select '.worksheet-problem .math_display .answer', false, "Solution should not be displayed for Worksheet#show"
  end
  
  test "edit worksheet" do
    get(:edit, {:id => @worksheet.id})
    assert_select '.problem-links input#replace-problem-submit-1'
    assert_response :success
  end
  
  test "new worksheet" do
    get :new
    assert_response :success
  end
  
  test "destroy worksheet" do
    assert_difference('Worksheet.count', -1) do
      delete :destroy, :id => @worksheet
    end
    assert_redirected_to dashboard_path    
  end
  
  test "update worksheet" do
    new_title = "This worksheet now has a different title"
    @worksheet.title = new_title
    put :update, :id => @worksheet.to_param, :worksheet => @worksheet.attributes
    assert_redirected_to edit_worksheet_path(assigns(:worksheet))
    assert_equal new_title, assigns[:worksheet].title
  end
end
