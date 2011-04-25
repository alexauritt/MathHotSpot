require 'test_helper'

class ProblemLevelsControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  def setup
    authenticate
  end

  test "should show" do
    @problem_level = problem_levels(:dividing_monomials_level_01)
    get :show, :id => @problem_level.to_param
    assert_response :success
  end


end
