require 'test_helper'
require 'mocha'

class MathProblemTemplateTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @template = MathProblemTemplate.new
    @level = @template.problem_levels.build
    @level2 = @template.problem_levels.build
  end
      
  test "use display mode by default" do
    assert MathProblemTemplate.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = MathProblemTemplate.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  
  test "demo problem" do
    @level.stubs(:demo_problem).returns(MathProblem.new)
    assert_instance_of MathProblem, @template.demo_problem
  end
  
  test "demo_problem returns empty problem when template has no levels defined" do
    @template.demo_problem
  end
  
  test "problem_count" do
    @level.stubs(:math_problems).returns([mock,mock])
    @level2.stubs(:math_problems).returns([mock,mock,mock])
    assert_equal 5, @template.problem_count
  end
  
  test "level_count" do
    assert_equal 2, @template.level_count
  end
  
  test "new template created with nested problem level" do
    params = {:math_problem_template => {:lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
    
    assert_difference('MathProblemTemplate.count') do
      assert MathProblemTemplate.create(params[:math_problem_template])
    end
    
  end
  
  test "new problem level created when nested in math problem template" do
    params = {:math_problems_template => {:lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
  
    assert_difference('ProblemLevel.count') do
      assert MathProblemTemplate.create(params[:math_problems_template]), @template.errors.to_s
    end    
  end

end
