require 'test_helper'

class ProblemLevelTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @level = ProblemLevel.new
    @level.math_problems.build
    @problem_type = @level.build_problem_type
  end

  test "factory level is valid" do
    assert Factory.build(:problem_level).valid?, "default FactoryGirl ProblemLevel is invalid, please update"
  end
  
  test "invalid with out problem_type assigned" do
    level = Factory.build(:problem_level, :problem_type => nil)
    assert !level.valid?
    assert level.errors.include? :problem_type_id    
  end

  test "problem_type_id error present after validating with invalid pt_id" do
    level = Factory.build(:problem_level, :problem_type_id => -765)
    assert !level.valid?
    assert level.errors.include? :problem_type_id    
  end

  test "demo problem" do
    assert_instance_of MathProblem, @level.demo_problem
  end
  
  test "demo_problem returns nil if no problems exist" do
    assert_nil ProblemLevel.new.demo_problem
  end
  
  test "display mode true by default" do
    assert @level.display_mode?
  end
  
  test "instruction" do
    @problem_type.stubs(:instruction).returns(Instruction.new)
    assert_instance_of Instruction, @level.instruction
  end
  
  test "problem_count" do
    level = ProblemLevel.new
    6.times { level.math_problems.build }
    assert_equal 6, level.problem_count
  end
  
  test "destory fails if level has math problem children" do
    level = ProblemLevel.new
    level.math_problems.build(:question_markup => 'some markup', :answer_markup => 'an answer')
    assert_equal false, level.destroy
  end
  
  test "destroy succeeds if no math problem children" do
    level = ProblemLevel.new
    assert level.destroy    
  end
  
  test "empty?" do
    level = ProblemLevel.new
    assert level.empty?
  end
  
  test "empty? false if math_problems present" do
    level = ProblemLevel.new
    level.math_problems.build
    assert !level.empty?
  end
  
  test "owner is owner of parent problem type" do
    mock_user = mock
    type = Factory.build(:problem_type)
    level = ProblemLevel.new(:problem_type => type, :level_number => type.lowest_available_level_number)
    type.expects(:owner).returns(mock_user)
    assert_equal mock_user, level.owner
  end
  
  test "nested math problems are assigned to owner of problem type by default" do
    type = problem_types(:dividing_monomials_problem_type)
    owner = users(:testuser)
    type.stubs(:owner).returns(owner)
    level = ProblemLevel.create(:problem_type => type, :level_number => type.lowest_available_level_number, 
      :math_problems_attributes => [{:question_markup => "asdf", :answer_markup => "asdf"}])

    assert level.valid?, "Level didn't save"
    assert_equal owner, level.math_problems.first.owner, "owner was not expected owner"
  end
  
  test "nested math problems are assigned to an owner specified in attributes" do
    type = problem_types(:dividing_monomials_problem_type)
    type_owner = users(:testuser)
    problem_owner = users(:joe)
    type.stubs(:owner).returns(type_owner)
    level = ProblemLevel.create(:problem_type => type, :level_number => type.lowest_available_level_number, 
      :math_problems_attributes => [{:owner => problem_owner, :question_markup => "asdf", :answer_markup => "asdf"}])

    assert level.valid?, "Level is invalid"
    assert_equal type_owner, level.owner
    assert_equal problem_owner, level.math_problems.first.owner, "owner was not expected owner"
  end
  
  test "problem_type_title" do
    title = "asdfsadf expected title"
    @problem_type.expects(:title).returns(title)
    assert_equal title, @level.problem_type_title
  end
  
end
