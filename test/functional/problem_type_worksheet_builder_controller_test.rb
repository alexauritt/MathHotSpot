require 'test_helper'

class ProblemTypeWorksheetBuilderControllerTest < AuthenticatingControllerTestCase

  def setup
    @problem_type = Factory.build(:problem_type)
  end
  
  test "new" do
    type = problem_types(:find_gcf_of_monomials_problem_type)
    get :new, :permalink => type.permalink
    assert_response :success
  end
end
