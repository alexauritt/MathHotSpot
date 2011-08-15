require 'test_helper'

class WorksheetSolutionsControllerTest < AuthenticatingControllerTestCase
  test "show" do
    get :show, :id => worksheets(:monomial_worksheet_01)
    assert assigns(:worksheet)
    assert_response :success
    assert_select '.worksheet_problem .math_display .answer'
  end  
end
