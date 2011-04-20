require 'test_helper'
require 'mocha'

class WorksheetTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  
  def setup
    @worksheet = Worksheet.new
  end

  test "problem_groups returns array of arrays of math_problems, sorted by instruction" do
    sheet = worksheets(:monomial_worksheet_01)
    problem_groups = sheet.problem_groups
    assert_equal 4, problem_groups.size
    problem_groups.each do |group|
      assert !group.empty?
      assert_all_have_same_instructions(group)
    end
  end

  test "no problem duplicated in problem_groups" do
    sheet = worksheets(:monomial_worksheet_01)
    problem_groups = sheet.problem_groups.flatten!
    assert_equal 10, problem_groups.size
    problem_groups.uniq!
    assert_equal 10, problem_groups.size
  end

  test "replace_problem fails if bad problem number specified" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 2 })

    assert_equal false, @worksheet.replace_problem(20)    
  end
  
  test "replace_problem delegates replacement to worksheet problem and excludes similar problems on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 4 })
    type1, type2 = mock, mock
    
    worksheet_problems = @worksheet.worksheet_problems
    worksheet_problems.first.stubs(:problem_type).returns(type1)
    WorksheetProblem.any_instance.stubs(:problem_type).returns(type2)
    worksheet_problems[1].expects(:replace_math_problem).with({:exclude => worksheet_problems[2..3]}).returns(true)

    @worksheet.replace_problem 2

  end

  test "replace_problems_2 replaces expected problem" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 3 })
    
    worksheet_problems = @worksheet.worksheet_problems
    
    middle_math_problem = worksheet_problems[1].math_problem
    replacement_problem = MathProblem.new(:question_markup => "this is the replacement problem")

    middle_math_problem.expects(:find_replacement).returns(replacement_problem)
    
    @worksheet.replace_problem 2
    
    assert_equal replacement_problem, @worksheet.worksheet_problems[1].math_problem
  end
  
  test "similar problems on worksheet" do
    worksheet = Worksheet.new
    template1 = mock
    template2 = mock
    worksheet.worksheet_problems.build.stubs(:problem_type).returns(template1)
    worksheet.worksheet_problems.build.stubs(:problem_type).returns(template1)
    worksheet.worksheet_problems.build.stubs(:problem_type).returns(template2)
    worksheet.worksheet_problems.build.stubs(:problem_type).returns(template1)
    prob1 = worksheet.worksheet_problems[0]
    prob2 = worksheet.worksheet_problems[1]
    prob3 = worksheet.worksheet_problems[2]
    prob4 = worksheet.worksheet_problems[3]

    assert_equal [prob2, prob4], worksheet.send(:similar_problems_on_worksheet, prob1)
  end

  private

  def assert_all_have_same_instructions(problem_group)
    instructions = problem_group.collect { |problem| problem.instruction }
    instructions.uniq!
    instructions.size == 1
  end
  
  def set_same_template_for_every_problem_on_worksheet_except_number(problem_number)
    template1, template2 = MathProblemTemplate.new, MathProblemTemplate.new
    @worksheet.worksheet_problems.each_with_index do |wp, index|
      template = (index == problem_number - 1) ? template1 : template2 
      wp.stubs(:problem_type).returns(template)
    end
  end  
  
  def assert_worksheet_contains_error(worksheet, error)
    assert worksheet.errors[:replace_failure].include?(error), "Following error expected on worksheet: #{error}"
  end
  
  def create_mock_worksheet_problems_for(worksheet, options = { :count => 1 })
    options[:count].times do |i|
      worksheet_problem = worksheet.worksheet_problems.build
      worksheet_problem.build_math_problem(:question_markup => "this is some question markup #{i}")
    end
  end
  
  def new_worksheet_problem_of_type(math_problem_template, problem_number)
    WorksheetProblem.new(:problem_number => problem_number, :math_problem => MathProblem.new(:id => problem_number, :math_problem_template => math_problem_template))
  end
  
end
