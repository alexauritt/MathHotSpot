require 'test_helper'

class GroupedProblemsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.

  def setup
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problem_groups)    
  end

end
