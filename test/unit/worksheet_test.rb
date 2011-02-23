require 'test_helper'
require 'mocha'

class WorksheetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @worksheet = Worksheet.new
  end
  
  test "replace_problem fails if specified problem number not found on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 2 })
    
    assert_equal false, @worksheet.replace_problem(3)

    assert_worksheet_contains_error @worksheet, Worksheet::Errors::PROBLEM_NUMBER_MISSING_ERROR
  end
  
  test "replace_problem suceeds if specified problem number found on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 2 })
    MathProblemTemplate.stubs(:find_replacement)

    assert_equal true, @worksheet.replace_problem(2)
  end
  
  test "replace_problem fails if specified problem is not replaceable" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 1 })
    math_problem = @worksheet.worksheet_problems.first.math_problem
    MathProblemTemplate.expects(:find_replacement).with(math_problem).returns(math_problem)
    
    @worksheet.replace_problem 1
    
    assert_worksheet_contains_error @worksheet, Worksheet::Errors::UNIQUE_PROBLEM_REPLACE_ERROR
  end
  
  test "replace_problems actually replaces expected problem" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 3 })
    
    worksheet_problems = @worksheet.worksheet_problems
    
    middle_math_problem = worksheet_problems[1].math_problem
    replacement_problem = MathProblem.new(:problem_markup => "this is the replacement problem")
    
    MathProblemTemplate.expects(:find_replacement).with(middle_math_problem).returns(replacement_problem)
    
    @worksheet.replace_problem 2
    
    assert_equal replacement_problem, @worksheet.worksheet_problems[1].math_problem
  end
  
  # test "replace_problem fails if all replaceable problems already present on worksheet" do
  #   flunk
  # end
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
      worksheet_problem.math_problem = MathProblem.new(:problem_markup => "some markup goes here #{i}")
      worksheet.worksheet_problems << worksheet_problem
    end
  end
end
