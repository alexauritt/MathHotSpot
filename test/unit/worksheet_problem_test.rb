require 'test_helper'

class WorksheetProblemTest < ActiveSupport::TestCase

  def setup
    @worksheet_problem = WorksheetProblem.new
    @worksheet_problem.build_math_problem
    @worksheet_problem.math_problem.build_math_problem_template

  end

  test "problem_type returns instance of MathProblemTemplate" do
    assert_instance_of MathProblemTemplate, @worksheet_problem.problem_type
  end
  
  test "problem_type returns UNDEFINED when appropriate" do
    assert_nil WorksheetProblem.new.problem_type
  end
    
end
