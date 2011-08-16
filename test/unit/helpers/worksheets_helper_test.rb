require 'test_helper'

class WorksheetsHelperTest < ActionView::TestCase
  test "display_problem_number" do
    wp = WorksheetProblem.new(:problem_number => 50)
    expected_display = "50)"
    assert_equal expected_display, display_problem_number(wp)
  end
end
