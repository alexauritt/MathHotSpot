require 'test_helper'

class RogueProblemsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    authenticate
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
