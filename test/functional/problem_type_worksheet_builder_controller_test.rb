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
    
  test "create delegates to WorksheetBuilder" do
    user = users(:testuser)
    @controller.stubs(:current_user).returns(user)
    builder_params =  {'owner' => user, 'title'=>"Roundabout", 'problems' => [{ 'permalink' =>"find-gcf-of-monomials", 
                          'problem_levels' =>{"1"=>"1", "2"=>"4"}}]}
    stub_problem_type_worksheet_builder_to_return_fixture_from! builder_params
    post :create, :worksheet_builder => builder_params, :permalink => @problem_type.permalink
  end
  
  private
  def stub_problem_type_worksheet_builder_to_return_fixture_from!(params)
    WorksheetBuilder.expects(:create).with(params).returns(worksheets(:monomial_worksheet_01))    
  end  
end
