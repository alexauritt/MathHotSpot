require 'test_helper'

class WorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  def setup
    @user = users(:testuser)
    @bad_params = {:hookah => "bookah"}                          
    @dummy_params = {"owner" => @user, "worksheet_builder" => {"random_stuff" => "asdfsa"}}
  end
  
  test "create redirects to new worksheet if WorksheetBuilder returns persistable worksheet" do
    @controller.stubs(:current_user).returns(@user)
    mock_builder_returning_worksheet!(@dummy_params, worksheets(:monomial_worksheet_01))

    post :create, :worksheet_builder => @dummy_params
    
    assert_redirected_to worksheets(:monomial_worksheet_01), "Should have been redirected to new Worksheet"
  end
  
  test "create fails and redirects to root if Builder fails to return persistable worksheet" do
    @controller.stubs(:current_user).returns(@user)
    mock_builder_returning_worksheet!(@dummy_params, Worksheet.new)

    post :create, :worksheet_builder => @dummy_params
    
    assert_redirected_to root_path, "Create should have failed: should have been rerouted to root."
  end
  
  test "successful build of worksheet" do
    first_level_id = 23423
    first_level_count = 2
    second_level_id = 928423
    second_level_count = 3
    problem_count = first_level_count + second_level_count
    first_problems = MathProblem.all(:limit => first_level_count)
    second_problems = MathProblem.all(:limit => second_level_count, :offset => first_level_count)
    @params = {:title => "this is going to be a new worksheet", :problem_levels_info => 
      {first_level_id.to_s => first_level_count, second_level_id => second_level_count}}
    MathProblem.expects(:all).with(:limit => second_level_count, :conditions => {:problem_level_id => second_level_id}).returns(second_problems)
    MathProblem.expects(:all).with(:limit => first_level_count, :conditions => {:problem_level_id => first_level_id}).returns(first_problems)
    assert_difference('WorksheetProblem.count', problem_count) do
      assert_difference('Worksheet.count') do
        post :create, :worksheet_builder => @params
      end
    end
    assert_redirected_to assigns(:worksheet)
  end

  private
  def mock_builder_returning_worksheet!(expected_params, worksheet_to_return)
    mock_builder = mock
    mock_builder.expects(:build).with(expected_params).returns(worksheet_to_return)
    WorksheetBuilder.expects(:new).returns(mock_builder)
  end
  
end
