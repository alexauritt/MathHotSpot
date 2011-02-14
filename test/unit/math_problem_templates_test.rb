require 'test_helper'
require 'mocha'

class MathProblemsTemplateTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @first_template = MathProblemTemplate.new(:id => 234)
    @first_problem = MathProblem.new(:math_problem_template => @first_template)
    @second_problem = MathProblem.new(:math_problem_template => @first_template)    
  end
  
  test "replace math problem returns different problem with same template" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([@first_problem, @second_problem])
    replacement = MathProblemTemplate.find_replacement(@first_problem)
    assert_equal(@second_problem, replacement)
  end
  
  test "find_replacement returns nil and raises if specified problem's template can not be found" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([])
    assert_raise ActiveRecord::RecordNotFound do
      assert_nil MathProblemTemplate.find_replacement(@first_problem)
    end
  end
  
  test "find_replacement returns same problem and raises if problem is one of a kind" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([@first_problem])
    assert_raise ActiveRecord::RecordNotFound do
      assert_equal(@first_problem, MathProblemTemplate.find_replacement(@first_problem))
    end
  end
end
