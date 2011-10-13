require 'test_helper'

class WorksheetProblemAdderHelperTest < ActionView::TestCase
  test "problem_numbers_to_update returns empty array if we added the second problem" do
    worksheet = Factory.build(:worksheet)
    worksheet.expects(:problem_count).returns(2)
    assert_equal [], problem_numbers_to_update(worksheet, :target_problem_number => 1)
  end
  
  test "problem_numbers_to_update returns list of problem numbers after newly inserted problem" do
    worksheet = Factory.build(:worksheet)
    worksheet.expects(:problem_count).returns(10)
    assert_equal (6..10).to_a, problem_numbers_to_update(worksheet, :target_problem_number => 4)    
  end
  
  test "problem_numbers_requiring_link_updates returns empty array if target problem has additional replacements available" do
    problem_number = 4
    worksheet = Factory.build(:worksheet)
    worksheet_problem = Factory.build(:worksheet_problem)

    # we test the new problem, which has been inserted immediately after the new target problem
    worksheet.expects(:problem).with(problem_number + 1).returns(worksheet_problem)
    worksheet_problem.expects(:replacement_available?).returns(true)
    
    assert_equal [], problem_numbers_requiring_link_updates(worksheet, :target_problem_number => problem_number)
  end

  test "problem_numbers_requiring_link_updates returns positions of all siblings of new prob on worksheet if level has been exhausted" do
    problem_number = 4
    worksheet = Factory.build(:worksheet)
    worksheet_problem = Factory.build(:worksheet_problem)
    siblings = []
    siblings << Factory.build(:worksheet_problem, :position => 4)
    siblings << Factory.build(:worksheet_problem, :position => 9)
    
    worksheet.expects(:problem).with(problem_number + 1).returns(worksheet_problem)
    worksheet_problem.expects(:replacement_available?).returns(false)
    worksheet_problem.expects(:siblings).returns(siblings)
    
    assert_equal [4,9], problem_numbers_requiring_link_updates(worksheet, :target_problem_number => problem_number)
  end
end