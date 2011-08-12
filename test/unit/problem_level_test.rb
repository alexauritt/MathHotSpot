require 'test_helper'

class ProblemLevelTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @level = ProblemLevel.new
    @level.math_problems.build
    @problem_type = @level.build_problem_type
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
    @problem_type.stubs(:instruction).returns(Instruction.new)
    assert_instance_of Instruction, @level.instruction
  end
  
  test "problem_count" do
    level = ProblemLevel.new
    6.times { level.math_problems.build }
    assert_equal 6, level.problem_count
  end
  
  test "destory fails if level has math problem children" do
    level = ProblemLevel.new
    level.math_problems.build(:question_markup => 'some markup', :answer_markup => 'an answer')
    assert_equal false, level.destroy
  end
  
  test "destroy succeeds if no math problem children" do
    level = ProblemLevel.new
    assert level.destroy    
  end
  
  test "empty?" do
    level = ProblemLevel.new
    assert level.empty?
  end
  
  test "empty? false if math_problems present" do
    level = ProblemLevel.new
    level.math_problems.build
    assert !level.empty?
  end
  
  test "owner is owner of parent problem type " do
    mock_user = mock
    type = Factory.build(:problem_type)
    level = ProblemLevel.new(:problem_type => type, :level_number => type.lowest_available_level_number)
    type.expects(:owner).returns(mock_user)
    assert_equal mock_user, level.owner
  end
  
end
