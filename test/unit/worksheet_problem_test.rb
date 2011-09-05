require 'test_helper'

class WorksheetProblemTest < ActiveSupport::TestCase

  def setup
    @worksheet_problem = WorksheetProblem.new
    @current_problem = @worksheet_problem.build_math_problem(:question_markup => "a question")
    @current_problem.build_problem_level
    # @current_problem.build_problem_type
  end

  test "problem_level returns instance of ProblemLevel" do
    assert_instance_of ProblemLevel, @worksheet_problem.problem_level
  end
  
  test "problem_level returns UNDEFINED when appropriate" do
    assert_nil WorksheetProblem.new.problem_level
  end
  
  test "replace_math_problem delegates to MathProblem" do
    new_math_problem = MathProblem.new
    
    @current_problem.expects(:find_problem_from_same_level).with({:exclude => []}).returns(new_math_problem)
    
    @worksheet_problem.replace_math_problem
    assert_equal new_math_problem, @worksheet_problem.math_problem
  end
  
  test "replace_math_problem excludes specified problems from replacement search" do
    new_math_problem = MathProblem.new
    similar_worksheet_problem = WorksheetProblem.new
    similar_math_problem = similar_worksheet_problem.build_math_problem
    
    @current_problem.expects(:find_problem_from_same_level).with({:exclude => [similar_math_problem]}).returns(new_math_problem)
    @worksheet_problem.replace_math_problem({:exclude => [similar_worksheet_problem]})
    
    assert_equal new_math_problem, @worksheet_problem.math_problem
  end

  test "destruction of worksheet problem should trigger renumeration of worksheet" do
    @fixture_worksheet = worksheets(:monomial_worksheet_01)
    middle_prob = @fixture_worksheet.problem 7
    middle_prob.destroy
    msg = "Worksheet should be automatically numbered after middle problem incorrectly renumbered."
    assert @fixture_worksheet.problems_sequentially_numbered?, msg
  end
  
end
