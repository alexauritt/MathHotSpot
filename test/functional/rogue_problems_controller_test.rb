require 'test_helper'

class RogueProblemsControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  def setup
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rogue_problems)    
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
