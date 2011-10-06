require 'test_helper'
require 'mocha'

class WorksheetTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  include RightRabbitErrors
  
  def setup
    @worksheet = Worksheet.new
    @fixture_worksheet = worksheets(:monomial_worksheet_01)
  end
  
  test "problem_exists? returns true for valid problem number" do
    good_problem_number = @fixture_worksheet.problem_count
    assert @fixture_worksheet.problem_exists? good_problem_number
  end
  
  test "problem_exists? returns false for invalid problem number" do
    bad_problem_number = @fixture_worksheet.problem_count + 1
    assert_equal false, @fixture_worksheet.problem_exists?(bad_problem_number)
  end
  
  test "empty? returns true if worksheet has no problems" do
    worksheet = Worksheet.new
    assert worksheet.empty?
  end
  
  test "empty? returns false if worksheet has at least one problem" do
    assert !@fixture_worksheet.empty?, "Worksheet should have been empty"
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

  test "replace_problem returns nil and generates replace_failure error if problem number specified is not on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 2 })

    assert_nil @worksheet.replace_problem(20)
    assert_not_nil @worksheet.errors[:replace_failure]
  
  end
  
  test "replace_problem delegates replacement to worksheet problem and excludes similar problems on worksheet" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 4 })
    WorksheetProblem.any_instance.stubs(:classified?).returns(true)
    
    level1, level2 = mock, mock
    
    worksheet_problems = @worksheet.worksheet_problems
    worksheet_problems.first.stubs(:problem_level).returns(level1)
    WorksheetProblem.any_instance.stubs(:problem_level).returns(level2)
    worksheet_problems[1].expects(:replace_math_problem).with({:exclude => worksheet_problems[2..3]}).returns(true)

    @worksheet.replace_problem 2
  end

  test "replace_problem replaces expected problem" do
    create_mock_worksheet_problems_for(@worksheet, { :count => 3 })
    WorksheetProblem.any_instance.stubs(:classified?).returns(true)
    
    worksheet_problems = @worksheet.worksheet_problems
    
    middle_math_problem = worksheet_problems[1].math_problem
    replacement_problem = MathProblem.new(:question_markup => "this is the replacement problem")

    middle_math_problem.expects(:find_problem_from_same_level).returns(replacement_problem)
    
    @worksheet.replace_problem 2
    
    assert_equal replacement_problem, @worksheet.worksheet_problems[1].math_problem
  end
  
  test "replace_problem returns nil if number specifies an unclassified problem" do
    worksheet = Factory.build(:worksheet)
    math_problem = Factory.build(:math_problem)
    math_problem.expects(:classified?).returns(false)
    worksheet.worksheet_problems.build(:math_problem => math_problem, :problem_number => 1)
    
    assert_nil worksheet.replace_problem(1)
  end
  
  test "problem_classified? queries appropriate worksheet_problem" do
    worksheet = Factory.build(:worksheet)
    worksheet_problem = worksheet.worksheet_problems.build

    worksheet_problem.expects(:classified?).returns(true)
    
    worksheet.problem_classified? 1
  end
  
  test "problem_classified? returns false if specified problem_number does not exist on worksheet" do
    worksheet = Factory.build(:worksheet)
    assert_equal false, worksheet.problem_classified?(40)
  end
  
  test "similar problems on worksheet" do
    worksheet = Worksheet.new
    template1 = mock
    template2 = mock
    worksheet.worksheet_problems.build.stubs(:problem_level).returns(template1)
    worksheet.worksheet_problems.build.stubs(:problem_level).returns(template1)
    worksheet.worksheet_problems.build.stubs(:problem_level).returns(template2)
    worksheet.worksheet_problems.build.stubs(:problem_level).returns(template1)
    prob1 = worksheet.worksheet_problems[0]
    prob2 = worksheet.worksheet_problems[1]
    prob3 = worksheet.worksheet_problems[2]
    prob4 = worksheet.worksheet_problems[3]

    assert_equal [prob2, prob4], worksheet.send(:similar_problems_on_worksheet, prob1)
  end
  
  test "problems_numbered_correctly? returns true for worksheet without gaps" do
    assert @fixture_worksheet.problems_sequentially_numbered?, "fixture worksheet should be correctly numbered"
  end
  
  test "problems_numbered_correctly? identifies gaps in problem numbering" do
    middle_prob = @fixture_worksheet.problem 7
    middle_prob.problem_number = worksheet_problems.size + 10
    middle_prob.save
    msg = "Worksheet should NOT be sequentially numbered after middle problem incorrectly renumbered, if worksheet has not been renumbered."
    assert !@fixture_worksheet.problems_sequentially_numbered?, msg
  end
  
  test "renumber_worksheet_problems! fixes gap in middle" do
    worksheet = worksheets(:monomial_worksheet_01)
    
    assert_difference('worksheet.problem_count', -1) do
      middle_problem = worksheet.problem 4
      middle_problem.destroy
      worksheet.renumber_worksheet_problems!
    end
    
    msg = "Worksheet problems not properly renumbered after deletion of problem in middle of worksheet"
    assert worksheet.problems_sequentially_numbered?, msg
  end
  
  test "renumber_worksheet_problems! fixes gap of two problems in middle" do
    worksheet = worksheets(:monomial_worksheet_01)
    
    assert_difference('worksheet.problem_count', -2) do
      middle_problem = worksheet.problem 4
      middle_problem.destroy
      middle_problem = worksheet.problem 5
      middle_problem.destroy
    
      worksheet.renumber_worksheet_problems!
    end
    
    msg = "Worksheet problems not properly renumbered after deletion of two problems in middle of worksheet"
    assert worksheet.problems_sequentially_numbered?, msg
  end
  
  test "remove_problem returns true if problem removed successfully" do
    assert @fixture_worksheet.remove_problem(1)
  end
  
  test "remove_problem returns false if problem was NOT removed successfully" do
    bad_problem_number = @fixture_worksheet.problem_count + 1
    assert_equal false, @fixture_worksheet.remove_problem(bad_problem_number)
  end
  
  test "renumber_worksheet_problems! renumbers unpersisted worksheet problems" do
    worksheet = Worksheet.new
    4.times do |index|
      prob = MathProblem.limit(1).offset(MathProblem.count).first
      bad_prob_number = rand(1000)
      worksheet.worksheet_problems.build(:math_problem => prob, :problem_number => bad_prob_number)      
    end

    worksheet.renumber_worksheet_problems!
    
    4.times do |index|
      assert_equal index+1, worksheet.worksheet_problems[index].problem_number
    end
  end
  
  test "can create new worksheet with nested worksheet problems" do
    prob1 = math_problems(:medium_monomial_problem_02)
    prob2 = math_problems(:simple_monomial_problem_03)
    worksheet_problems_attributes = {"0" => {:math_problem_id => prob1.id, 
      :problem_number => 10}, "1" => {:math_problem_id => prob2.id, :problem_number => 2}}
    assert_difference('Worksheet.count') do
      assert_difference('WorksheetProblem.count', 2) do
        w = Worksheet.create(:title => "a new worksheet", :owner => User.first, 
          :worksheet_problems_attributes => worksheet_problems_attributes)
      end
    end
  end
  
  test "add_problem_like! returns nil if specified problem number not present on worksheet" do
    worksheet = create_worksheet_with_all_problems_from_same_level!
    assert_nil worksheet.add_problem_like! 2
    msg = MathHotSpotErrors::WorksheetModifierErrors::Messages::PROBLEM_NUMBER_MISSING_FOR_ADD_LIKE
    assert worksheet.errors[:base].include? msg
  end
  
  test "add_problem_like! returns nil if specified problem number not classified" do
    worksheet = Factory.build(:worksheet)
    worksheet_problem_attributes = Factory.attributes_for(:worksheet_problem, :worksheet => worksheet, :problem_number => 1)
    worksheet_problem = worksheet.worksheet_problems.build(worksheet_problem_attributes)
    worksheet_problem.expects(:classified?).returns(false)
    assert_nil worksheet.add_problem_like! 1
    
    expected_msg = MathHotSpotErrors::WorksheetModifierErrors::Messages::PROBLEM_NUMBER_UNCLASSIFIED_FOR_ADD_LIKE
    assert worksheet.errors[:base].include? expected_msg
  end
  
  test "add_problem_like! creates and returns a new worksheet problem" do
    prob_number = 2
    worksheet = create_worksheet_with_all_problems_from_same_level! :problem_count => 3
    copy_math_problem = worksheet.problem(prob_number).math_problem
    new_math_prob = new_persisted_math_problem(copy_math_problem.problem_level)
    copy_math_problem.expects(:find_problem_from_same_level).returns(new_math_prob)
    
    assert_difference("WorksheetProblem.count") do
      assert_difference('worksheet.problem_count') do
        new_worksheet_prob = worksheet.add_problem_like! prob_number
        assert new_worksheet_prob.is_a? WorksheetProblem        
      end
    end
  end

  test "add_problem_like! adds new problem to back of worksheet" do
    worksheet = create_worksheet_with_all_problems_from_same_level! :problem_count => 3
    new_prob = new_persisted_math_problem(worksheet.worksheet_problems.first.problem_level)
    
    worksheet.problem(1).math_problem.expects(:find_problem_from_same_level).returns(new_prob)
    worksheet.add_problem_like! 1
    
    last_worksheet_prob = worksheet.worksheet_problems.last

    assert_equal new_prob, last_worksheet_prob.math_problem
    assert_equal 4, last_worksheet_prob.problem_number
  end
  
  test "add_problem_like! returns nil and sets error if problem is unique" do
    worksheet = create_worksheet_with_all_problems_from_same_level!
    WorksheetProblem.any_instance.stubs(:classified?).returns(true)
    first_mp = MathProblem.new
    first_mp.expects(:find_problem_from_same_level).raises(UniqueProblemError.new)
    first_wp = worksheet.worksheet_problems.first
    first_wp.stubs(:math_problem).returns(first_mp)
    assert_nil worksheet.add_problem_like! 1
    assert worksheet.errors[:base].include? UNIQUE_PROBLEM_ERROR
  end
  
  test "next available problem number for empty worksheet" do
    worksheet = Worksheet.new
    assert_equal 1, worksheet.next_available_problem_number
  end
  
  test "next available problem number for real worksheet" do
    worksheet = worksheets(:monomial_worksheet_01)
    prob_count = worksheet.worksheet_problems.size
    assert_equal prob_count + 1, worksheet.next_available_problem_number
  end
  
  test "problem_types method queries all math problems for problem types" do
    type1 = Factory.build(:problem_type)
    type2 = Factory.build(:problem_type)
    
    math_problems = []
    5.times do |i|
      mp = Factory.build(:math_problem)
      problem_type = i.even? ? type1 : type2
      mp.stubs(:problem_type).returns(problem_type)
      math_problems << mp
    end
    
    @worksheet.math_problems = math_problems
    
    expected_type_list = [type1, type2].sort
    actual_type_list = @worksheet.problem_types.sort
    
    assert_equal expected_type_list, actual_type_list
  end
  
  test "problem_types method ignores unclassified math problems" do
    type1 = Factory.build(:problem_type)
    type2 = Factory.build(:problem_type)
    
    math_problems = []

    mp = Factory.build(:math_problem, :problem_level => nil)
    math_problems << mp

    5.times do |i|
      mp = Factory.build(:math_problem)
      problem_type = i.even? ? type1 : type2
      mp.stubs(:problem_type).returns(problem_type)
      math_problems << mp
    end

    mp = Factory.build(:math_problem, :problem_level => nil)
    math_problems << mp
    
    @worksheet.math_problems = math_problems

    expected_type_list = [type1, type2].sort
    actual_type_list = @worksheet.problem_types.sort
    
    assert_equal expected_type_list, actual_type_list
  end
  
  test "unclassified_problems returns math problems excludes classified problems" do
    math_probs = FactoryGirl.build_list(:math_problem, 20)
    math_probs[0..9].each { |mp| mp.stubs(:classified?).returns(false) }
    math_probs[10..14].each { |mp| mp.stubs(:classified?).returns(true) }
    math_probs[15..19].each { |mp| mp.stubs(:classified?).returns(false) }
    @worksheet.math_problems = math_probs
    
    expected_unclassifieds = math_probs[0..9] + math_probs[15..19]
    
    assert_equal expected_unclassifieds, @worksheet.unclassified_problems
  end
  
  private

  def create_worksheet_with_all_problems_from_same_level!(attr = {:problem_count => 1})
    worksheet = Factory.create(:worksheet)
    level = ProblemLevel.new
    work_prob_attributes = []
    attr[:problem_count].times {|i| work_prob_attributes << Factory.attributes_for(:worksheet_problem, 
        :problem_number => i+1, :math_problem => new_persisted_math_problem(level))}
    worksheet.worksheet_problems.build work_prob_attributes
    worksheet
  end
  
  def new_persisted_math_problem(level)
    Factory.create(:math_problem, :problem_level => level)
  end

  def assert_all_have_same_instructions(problem_group)
    instructions = problem_group.collect { |problem| problem.instruction }
    instructions.uniq!
    instructions.size == 1
  end
  
  def set_same_template_for_every_problem_on_worksheet_except_number(problem_number)
    template1, template2 = ProblemType.new, ProblemType.new
    @worksheet.worksheet_problems.each_with_index do |wp, index|
      template = (index == problem_number - 1) ? template1 : template2 
      wp.stubs(:problem_level).returns(template)
    end
  end  
  
  def assert_worksheet_contains_error(worksheet, error)
    assert worksheet.errors[:replace_failure].include?(error), "Following error expected on worksheet: #{error}"
  end
  
  def create_mock_worksheet_problems_for(worksheet, options = { :count => 1 })
    options[:count].times do |i|
      math_problem = Factory.build(:math_problem)
      worksheet.worksheet_problems << Factory.build(:worksheet_problem, :problem_number => i+1, :worksheet => worksheet, :math_problem => math_problem)
    end
  end
  
  def new_worksheet_problem_of_type(problem_type, problem_number)
    WorksheetProblem.new(:problem_number => problem_number, :math_problem => MathProblem.new(:id => problem_number, :problem_type => problem_type))
  end
  
end
