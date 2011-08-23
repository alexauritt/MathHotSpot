require 'test_helper'

class ProblemTypeWorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  test "show" do
    type = problem_types(:find_gcf_of_monomials_problem_type)
    get :show, :permalink => type.permalink
    assert_response :success
  end
end
