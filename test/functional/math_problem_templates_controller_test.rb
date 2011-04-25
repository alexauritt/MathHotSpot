require 'test_helper'

class MathProblemTemplatesControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    authenticate
  end

  test "show" do
    template = math_problem_templates(:dividing_monomials_template)
    get :show, :id => template.id
    assert_response :success
  end
end
