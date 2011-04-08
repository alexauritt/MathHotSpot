require 'test_helper'
require 'mocha'

class MathProblemTemplateTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @first_template = MathProblemTemplate.new(:id => 234)
    @first_problem = stub(:math_problem_template => @first_template, :id => 555)
    @second_problem = stub(:math_problem_template => @first_template, :id => 556)
    @third_problem = stub(:math_problem_template => @first_template, :id => 557) 
    @three_problems = [@first_problem, @second_problem, @third_problem]
  end
  
  test "replace math problem returns different problem with same template" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([@first_problem, @second_problem])
    replacement = MathProblemTemplate.find_replacement(@first_problem)
    assert_equal(@second_problem, replacement)
  end
  
  test "find_replacement raises if specified problem's template can not be found" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([])
    assert_raise ActiveRecord::RecordNotFound do
      MathProblemTemplate.find_replacement(@first_problem)
    end
  end
  
  test "find_replacement returns problem not being replaced and not exluded" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns(@three_problems)
    replacement = MathProblemTemplate.find_replacement(@first_problem, {:exclude => [@second_problem.id] })
    assert_equal @third_problem, replacement
  end

  test "find_replacement raises if problem is one of a kind" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([@first_problem])
    assert_raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR do
      MathProblemTemplate.find_replacement(@first_problem)
    end
  end
  
  test "find_replacement raises if all available problems excluded" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@first_template.id).returns([@first_problem, @second_problem])
    assert_raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING do
      MathProblemTemplate.find_replacement(@first_problem, {:exclude => [@second_problem.id]})
    end
  end
  
  test "use display mode by default" do
    assert MathProblemTemplate.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = MathProblemTemplate.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  

end
