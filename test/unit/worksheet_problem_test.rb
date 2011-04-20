require 'test_helper'

class WorksheetProblemTest < ActiveSupport::TestCase

  def setup
    @worksheet_problem = WorksheetProblem.new
    @current_problem = @worksheet_problem.build_math_problem(:question_markup => "a question")
    @current_problem.build_math_problem_template

  end

  test "problem_type returns instance of MathProblemTemplate" do
    assert_instance_of MathProblemTemplate, @worksheet_problem.problem_type
  end
  
  test "problem_type returns UNDEFINED when appropriate" do
    assert_nil WorksheetProblem.new.problem_type
  end
  
  test "replace_math_problem delegates to MathProblem" do
    new_math_problem = MathProblem.new
    
    @current_problem.expects(:find_replacement).with({:exclude => []}).returns(new_math_problem)
    
    @worksheet_problem.replace_math_problem
    assert_equal new_math_problem, @worksheet_problem.math_problem
  end
  
  test "replace_math_problem excludes specified problems from replacement search" do
    new_math_problem = MathProblem.new
    similar_worksheet_problem = WorksheetProblem.new
    similar_math_problem = similar_worksheet_problem.build_math_problem
    
    @current_problem.expects(:find_replacement).with({:exclude => [similar_math_problem]}).returns(new_math_problem)
    @worksheet_problem.replace_math_problem({:exclude => [similar_worksheet_problem]})
    
    assert_equal new_math_problem, @worksheet_problem.math_problem
  end
  
end
