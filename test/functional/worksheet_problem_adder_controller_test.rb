require 'test_helper'

class WorksheetProblemAdderControllerTest < AuthenticatingControllerTestCase
  include RightRabbitErrors
  def setup
    @worksheet = Factory.build(:worksheet)
    @worksheet.stubs(:to_param).returns('23') # random id so worksheet is routable
    @new_worksheet_problem = Factory.build(:worksheet_problem, :worksheet => @worksheet)
    @worksheet_id = 6666
    @problem_number = 3    
    
  end
  test "create delegates to Worksheet add_problem_like" do

    @worksheet.expects(:add_problem_like!).with(@problem_number).returns(@new_worksheet_problem)
    Worksheet.expects(:find).with(@worksheet_id).returns(@worksheet)
    
    post :create, :worksheet_problem_adder => {:worksheet_id => @worksheet_id, :problem_number => @problem_number}
    assert_template "worksheets/show"
    assert_response :success
    assert_error_message false
  end
  
  test "renders worksheet with error if add_problem_like! returns nil and adds base error to worksheet" do
    @worksheet.errors[:base] = UNIQUE_PROBLEM_ERROR
    @worksheet.expects(:add_problem_like!).with(@problem_number).returns(nil)
    Worksheet.expects(:find).with(@worksheet_id).returns(@worksheet)
        
    post :create, :worksheet_problem_adder => {:worksheet_id => @worksheet_id, :problem_number => @problem_number}
    assert_response :success
    assert_template "worksheets/show"
    assert_select 'div.notice', UNIQUE_PROBLEM_ERROR
  end
  
  private
  def assert_error_message(bool = true)
    assert_select 'div.notice', bool
  end
end
