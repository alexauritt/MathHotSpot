require 'test_helper'

class ProblemTypeWorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  test "new" do
    type = problem_types(:find_gcf_of_monomials_problem_type)
    get :new, :permalink => type.permalink
    assert_response :success
  end
  
  test "create" do
    pending
  end
end
