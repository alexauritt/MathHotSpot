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
  
  test "create" do
    builder_params =  {"title"=>"Roundabout", "problems"=>[{"permalink"=>"find-gcf-of-monomials", 
                                  "problem_levels"=>{"1"=>"1", "2"=>"4"}}]}
    post :create, :worksheet_builder => builder_params, :permalink => @problem_type.permalink
    assert_redirected_to assigns(:worksheet)
  end
end
