require 'test_helper'
require 'mocha'

class MathProblemTest < ActiveSupport::TestCase

  def setup
  end
  
  test "group_all_by_problem_template" do
    @first = MathProblem.new
    @second = MathProblem.new
    @third = MathProblem.new
    @fourth = MathProblem.new
    first_template = mock
    second_template = mock
    @first.stubs(:math_problem_template).returns(first_template)
    @second.stubs(:math_problem_template).returns(second_template)
    @third.stubs(:math_problem_template).returns(first_template)
    @fourth.stubs(:math_problem_template).returns(first_template)
    stub_math_problem_order_to_return_sorted_list([@first, @third, @fourth, @second])
    groups = MathProblem.group_all_by_template
    assert_equal 2, groups.size
    assert_equal 3, groups.first.size
  end

  test "rougue_problems" do
    rougues = MathProblem.rougue_problems
    assert_not_nil rougues
    assert rougues.size != 0
  end
  
  test "all problems are either rougue or grouped" do
    rougues = MathProblem.rougue_problems
    grouped = MathProblem.grouped_problems
    assert_equal MathProblem.count, rougues.size + grouped.size
  end
  
  test "display_mode? returns true (default) if no math_problem_template defined" do
    assert MathProblem.new.display_mode?
  end
  
  def stub_math_problem_order_to_return_sorted_list(ordered_problem_list)
    MathProblem.stubs(:grouped_problems).returns(ordered_problem_list)
  end  
end