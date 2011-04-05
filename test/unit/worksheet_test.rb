require 'test_helper'
require 'mocha'

class WorksheetTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @worksheet = Worksheet.new
  end

  # controller test instead
  # test "replace_problem fails if specified problem number not found on worksheet" do
  #   create_mock_worksheet_problems_for(@worksheet, { :count => 2 })    
  #   assert_equal false, @worksheet.replace_problem(3)
  #   assert_worksheet_contains_error @worksheet, ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR
  # end

  # test "replace_problem fails if all replaceable problems already present on worksheet" do
  #   flunk
  # end
    
  # write controller test instead
  # test "replace_problem fails if specified problem is not replaceable" do
  #   create_mock_worksheet_problems_for(@worksheet, { :count => 1 })
  #   math_problem = @worksheet.worksheet_problems.first.math_problem
  #   MathProblemTemplate.expects(:find_replacement).with(math_problem, {:exclude => []}).returns(math_problem)
  #   
  #   @worksheet.replace_problem 1
  #   
  #   assert_worksheet_contains_error @worksheet, ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR
  # end
  
  test "replace_problem suceeds if specified problem number found on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 2 })
    MathProblemTemplate.stubs(:find_replacement)

    assert_equal true, @worksheet.replace_problem(2)
  end

  test "replace_problems actually replaces expected problem" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 3 })
    
    worksheet_problems = @worksheet.worksheet_problems
    
    middle_math_problem = worksheet_problems[1].math_problem
    replacement_problem = MathProblem.new(:question_markup => "this is the replacement problem")
    
    MathProblemTemplate.expects(:find_replacement).with(middle_math_problem, {:exclude => []}).returns(replacement_problem)
    
    @worksheet.replace_problem 2
    
    assert_equal replacement_problem, @worksheet.worksheet_problems[1].math_problem
  end
  
  test "ids_of_similar_problems_on_worksheet (helper method)" do
    mp1 = mock
    mp2 = mock
    mp3 = mock
  
    wp1 = mock
    wp1.stubs(:math_problem => mp1)
    wp2 = mock
    wp2.stubs(:math_problem => mp2)
    wp3 = mock
    wp3.stubs(:math_problem => mp3)
    
    
    mp_temp1 = mock
    mp_temp2 = mock
  
    mp1.stubs(:id => 123, :math_problem_template => mp_temp1)
    mp2.stubs(:id => 456, :math_problem_template => mp_temp1)
    mp3.stubs(:id => 789, :math_problem_template => mp_temp2)        
    
    @sheet = Worksheet.new
    @sheet.stubs(:math_problems).returns([mp1,mp2,mp3])       # should not have to stub these active record refs. mocha bug?
    @sheet.stubs(:worksheet_problems).returns([wp1,wp2,wp3])  # should not have to stub these active record refs. mocha bug?
    assert_equal [mp2.id], @sheet.send(:ids_of_similar_problems_on_worksheet, mp1)
  end

  test "replace_problem does not replace with other problems of same type on worksheet" do
    w = Worksheet.new
    mpt1 = MathProblemTemplate.new(:id => 8976)
    mpt2 = MathProblemTemplate.new(:id => 5332)

    wp1 = new_worksheet_problem_of_type(mpt1, 1)
    wp2 = new_worksheet_problem_of_type(mpt1, 2)
    
    wp3 = new_worksheet_problem_of_type(mpt2, 3)
    
    replacement = MathProblem.new(:math_problem_template => mpt1, :id => 9994)

    w.worksheet_problems = [wp1, wp2, wp3]
    w.math_problems = w.worksheet_problems.map {|p| p.math_problem }

    assert_not_equal wp2.math_problem, replacement
    assert_equal wp2.math_problem, w.worksheet_problems[1].math_problem

    MathProblemTemplate.expects(:find_replacement).with(wp2.math_problem, {:exclude => [wp1.math_problem.id]}).returns(replacement)
    w.replace_problem(2)

    assert_equal replacement, w.worksheet_problems[1].math_problem
  end

  # 
  # test "replace_problem wraps everything in single db transaction" do
  #   flunk
  # end
  
  private
  
  def assert_worksheet_contains_error(worksheet, error)
    assert worksheet.errors[:replace_failure].include?(error), "Following error expected on worksheet: #{error}"
  end
  
  def create_mock_worksheet_problems_for(worksheet, options = { :count => 1 })
    options[:count].times do |i|
      worksheet_problem = WorksheetProblem.new(:problem_number => i+1)
      worksheet_problem.math_problem = MathProblem.new(:question_markup => "some markup goes here #{i}")
      worksheet.worksheet_problems << worksheet_problem
    end
  end
  
  def new_worksheet_problem_of_type(math_problem_template, problem_number)
    WorksheetProblem.new(:problem_number => problem_number, :math_problem => MathProblem.new(:id => problem_number, :math_problem_template => math_problem_template))
  end
  
end
