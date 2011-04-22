require 'test_helper'
require 'mocha'

class MathProblemTemplateTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @template = MathProblemTemplate.new
    @level = @template.problem_levels.build
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
  
end
