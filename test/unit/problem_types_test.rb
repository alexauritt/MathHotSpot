require 'test_helper'
require 'mocha'

class ProblemTypeTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @problem_type = ProblemType.new
    @level = @problem_type.problem_levels.build
    @level2 = @problem_type.problem_levels.build
  end
      
  test "use display mode by default" do
    assert ProblemType.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = ProblemType.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  
  test "demo problem" do
    @level.stubs(:demo_problem).returns(MathProblem.new)
    assert_instance_of MathProblem, @problem_type.demo_problem
  end
  
  test "demo_problem returns empty problem when template has no levels defined" do
    @problem_type.demo_problem
  end
  
  test "problem_count" do
    @level.stubs(:math_problems).returns([mock,mock])
    @level2.stubs(:math_problems).returns([mock,mock,mock])
    assert_equal 5, @problem_type.problem_count
  end
  
  test "level_count" do
    assert_equal 2, @problem_type.level_count
  end
  
  test "new template created with nested problem level" do
    params = {:problem_type => {:lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
    
    assert_difference('ProblemType.count') do
      assert ProblemType.create(params[:problem_type])
    end
    
  end
  
  test "new problem level created when nested in math problem template" do
    params = {:math_problems_template => {:lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
  
    assert_difference('ProblemLevel.count') do
      assert ProblemType.create(params[:math_problems_template]), @problem_type.errors.to_s
    end    
  end

end
