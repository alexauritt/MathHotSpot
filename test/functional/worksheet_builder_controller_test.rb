require 'test_helper'

class WorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  test "create" do
    user = users(:testuser)
    @controller.stubs(:current_user).returns(user)
    builder_params =  {'title'=>"Roundabout", 'problems' => [{ 'permalink' =>"find-gcf-of-monomials", 
                          'problem_levels' =>{"1"=>"1", "2"=>"4"}}]}
    stub_problem_type_worksheet_builder_to_return_fixture_from! builder_params.merge({"owner" => user})
    post :create, :worksheet_builder => builder_params
  end
  
  private
  def stub_problem_type_worksheet_builder_to_return_fixture_from!(params)
    WorksheetBuilder.expects(:create).with(params).returns(worksheets(:monomial_worksheet_01))    
  end  

end
