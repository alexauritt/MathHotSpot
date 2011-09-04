require 'test_helper'

class WorksheetsHelperTest < ActionView::TestCase
  test "display_problem_number" do
    wp = WorksheetProblem.new(:problem_number => 50)
    expected_display = "50)"
    assert_equal expected_display, display_problem_number(wp)
  end
  
  test "problem_group_instructions returns expected text" do
    expected_msg = "Solve the damn problem."
    mock_prob = MathProblem.new
    mock_prob.stubs(:instruction_description).returns(expected_msg)
    prob_group = Array.new(4) {|i| Factory.build(:worksheet_problem, :problem_number => (i + 15), :math_problem => mock_prob, :worksheet => Worksheet.new) }
    expected_message = "Problems 15, 16, 17, 18: Solve the damn problem."
    assert_equal expected_message, problem_group_instructions(prob_group)
  end
end
