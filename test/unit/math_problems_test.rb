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
  
  def stub_math_problem_order_to_return_sorted_list(ordered_problem_list)
    MathProblem.stubs(:order).with("math_problem_template_id").returns(ordered_problem_list)
  end  
end