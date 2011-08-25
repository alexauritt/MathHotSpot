require 'test_helper'

class WorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  def setup
    @user = users(:testuser)
    @bad_params = {:hookah => "bookah"}
    @good_params_in_progress = {'title'=>"Roundabout", 'problems' => [{ 'permalink' =>"find-gcf-of-monomials", 
                          'problem_levels' =>{"1"=>"1", "2"=>"4"}}]}
                          
    @dummy_params = {"owner" => @user, "worksheet_builder" => {"random_stuff" => "asdfsa"}}
  end

  test "create redirects to new worksheet if WorksheetBuilder returns persistable worksheet" do
    @controller.stubs(:current_user).returns(@user)
    WorksheetBuilder.expects(:build).with(@dummy_params).returns(worksheets(:monomial_worksheet_01))        
    post :create, :worksheet_builder => @dummy_params
    
    assert_redirected_to worksheets(:monomial_worksheet_01), "Should have been redirected to new Worksheet"
  end
  
  test "create fails and redirects to root if Builder fails to return persistable worksheet" do
    @controller.stubs(:current_user).returns(@user)
    WorksheetBuilder.expects(:build).with(@dummy_params).returns(Worksheet.new)
    post :create, :worksheet_builder => @dummy_params
    
    assert_redirected_to root_path, "Create should have failed: should have been rerouted to root."
  end
  
end
