require 'test_helper'

class WorksheetsHelperTest < ActionView::TestCase
  test "display_problem_number" do
    wp = WorksheetProblem.new(:problem_number => 50)
    expected_display = "50)"
    assert_equal expected_display, display_problem_number(wp)
  end
  
  test "problem_group_instructions returns expected text" do
    expected_msg = "Solve the damn problem."
    prob_group = problem_group_numbered((15..18))
    prob_group.each {|wp| wp.math_problem.stubs(:instruction_description).returns(expected_msg)}
    
    expected_message = "Problems #15, 16, 17, 18: Solve the damn problem."
    assert_equal expected_message, problem_group_instructions(prob_group)
  end
  
  test "problem_group_instructions returns unpluralized text" do
    expected_msg = "Solve the silly problem."
    single_prob_in_group = problem_group_numbered
    single_prob_in_group.first.stubs(:instruction_description).returns(expected_msg)
    
    expected_message = "Problem #1: Solve the silly problem."
    assert_equal expected_message, problem_group_instructions(single_prob_in_group)
  end

  private
  def problem_group_numbered(number_range = (1..1))
    first_num = number_range.first
    Array.new(number_range.count) {|i| Factory.build(:worksheet_problem, :problem_number => (i + first_num), :math_problem => MathProblem.new, :worksheet => Worksheet.new) }
  end
  
end
