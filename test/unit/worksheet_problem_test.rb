require 'test_helper'

class WorksheetProblemTest < ActiveSupport::TestCase

  def setup
    @worksheet_problem = WorksheetProblem.new
    @current_math_problem = @worksheet_problem.build_math_problem(:question_markup => "a question")
    @current_worksheet = @worksheet_problem.build_worksheet
    @current_math_problem.build_problem_level
  end

  test "problem_level returns instance of ProblemLevel" do
    assert_instance_of ProblemLevel, @worksheet_problem.problem_level
  end
  
  test "problem_level returns UNDEFINED when appropriate" do
    assert_nil WorksheetProblem.new.problem_level
  end
  
  test "replace_math_problem delegates to MathProblem" do
    new_math_problem = MathProblem.new
    
    @current_math_problem.expects(:find_problem_from_same_level).with({:exclude => []}).returns(new_math_problem)
    
    @worksheet_problem.replace_math_problem
    assert_equal new_math_problem, @worksheet_problem.math_problem
  end
  
  test "replace_math_problem excludes specified problems from replacement search" do
    new_math_problem = MathProblem.new
    similar_worksheet_problem = WorksheetProblem.new
    similar_math_problem = similar_worksheet_problem.build_math_problem
    
    @current_math_problem.expects(:find_problem_from_same_level).with({:exclude => [similar_math_problem]}).returns(new_math_problem)
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
  
  test "worksheet_problem accepts nested attributes for new math problem belonging to existing PT/PL" do
    worksheet = Factory.build(:worksheet)
    problem_level_id = 234
    user_id = 243234
    prob_attrs = Factory.attributes_for(:math_problem, :problem_level_id => problem_level_id, :owner_id => user_id)
    ProblemLevel.expects(:exists?).with(problem_level_id).returns(true)
    User.expects(:exists?).with(user_id).returns(true)
    
    assert_difference('WorksheetProblem.count') do
      assert_difference('MathProblem.count') do
        wp = WorksheetProblem.create(:worksheet => worksheet, :problem_number => 1, :math_problem_attributes => prob_attrs)
      end
    end
  end
  
  test "level_number delegates to problem level" do
    wp = Factory.build(:worksheet_problem)
    wp.problem_level.stubs(:level_number).returns(90)
    assert_equal 90, wp.level_number
  end
  
  test "level_number returns nil but does not raise if problem_level nil" do
    wp = Factory.build(:worksheet_problem, :math_problem => nil)
    assert_nothing_raised do
      assert_nil wp.level_number
    end
  end
    
  test "replacement_available? excludes similar problems from worksheet from consideration" do
    similar_worksheet_problems = Array.new(3, WorksheetProblem.new)
    similar_worksheet_problems.each {|wp| wp.build_math_problem }
    similar_math_problems = similar_worksheet_problems.map {|wp| wp.math_problem }
    
    @current_worksheet.expects(:similar_problems_on_worksheet).with(@worksheet_problem).returns(similar_worksheet_problems)
    @current_math_problem.expects(:sibling_available?).with({:exclude => similar_math_problems}).returns(true)

    assert @worksheet_problem.replacement_available?
  end
  
end
