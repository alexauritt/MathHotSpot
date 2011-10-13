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

    assert_redirected_to edit_worksheet_path(@worksheet)
    assert_no_error_message
  end
  
  test "create saves target problem number for view" do
    @worksheet.expects(:add_problem_like!).with(@problem_number).returns(@new_worksheet_problem)
    Worksheet.expects(:find).with(@worksheet_id).returns(@worksheet)
    
    post :create, :worksheet_problem_adder => {:worksheet_id => @worksheet_id, :problem_number => @problem_number}

    assert_equal @problem_number, assigns(:target_problem_number)
  end
  
  test "renders worksheet with error if add_problem_like! returns nil and adds base error to worksheet" do
    @worksheet.errors[:base] = UNIQUE_PROBLEM_ERROR
    @worksheet.expects(:add_problem_like!).with(@problem_number).returns(nil)
    Worksheet.expects(:find).with(@worksheet_id).returns(@worksheet)
        
    post :create, :worksheet_problem_adder => {:worksheet_id => @worksheet_id, :problem_number => @problem_number}
    assert_redirected_to edit_worksheet_path(@worksheet)
    assert_error_message UNIQUE_PROBLEM_ERROR
  end

end
