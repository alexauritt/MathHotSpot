require 'test_helper'

class ProblemLevelTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @level = ProblemLevel.new
    @level.math_problems.build
    @template = @level.build_math_problem_template
  end
  
  test "demo problem" do
    assert_instance_of MathProblem, @level.demo_problem
  end
  
  test "demo_problem returns nil if no problems exist" do
    assert_nil ProblemLevel.new.demo_problem
  end
  
  test "display mode true by default" do
    assert @level.display_mode?
  end
  
  test "instruction" do
    @template.stubs(:instruction).returns(Instruction.new)
    assert_instance_of Instruction, @level.instruction
  end
  
  test "problem_count" do
    level = ProblemLevel.new
    6.times { level.math_problems.build }
    assert_equal 6, level.problem_count
  end
end
