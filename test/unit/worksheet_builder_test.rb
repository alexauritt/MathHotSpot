require 'test_helper'
require 'mocha'

class WorksheetBuilderTest < ActiveSupport::TestCase

  def setup
    @user = users(:testuser)
    @builder = WorksheetBuilder.new
  end
  test "create empty worksheet" do
    assert_difference('Worksheet.count') do
      @worksheet = @builder.build(:owner => @user, :title => "new worksheet")
      @worksheet.save
    end
    assert_equal "new worksheet", @worksheet.title
    assert_equal @user, @worksheet.owner
  end
  
  test "returns invalid Worksheet if no owner specified" do
    worksheet = @builder.build(:title => "invalid worksheet")
    assert !worksheet.valid?, "Worksheet should be invalid"
  end
  
  test "build returns empty Worksheet without attributes if attributes invalid" do
    worksheet = @builder.build(:whoohasdofijawe => "asdlfjasdf", :title => 'title should not be set')
    assert_equal false, worksheet.valid?, "Worksheet should not be valid, but should be present"
    assert_nil worksheet.title
  end
  
  test "random problems retrieved through MathProblem" do
    problem_type = problem_types(:dividing_monomials_problem_type)
    type_level_first = problem_type.problem_levels.first
    problems_from_first_level = [math_problems(:simple_monomial_problem_03), math_problems(:simple_monomial_problem_02)]
    problems_from_last_level =[math_problems(:medium_monomial_problem_01)]
    type_level_last = problem_type.problem_levels.last
    first_count = 2
    last_count = 1
    expect_problem_count = first_count + last_count
    level_quantity_specs = {type_level_first.id.to_s => first_count.to_s, type_level_last.id.to_s => last_count.to_s}
    assert type_level_last != type_level_first, "Test requires fixture Problem Type to have at least 2 problem levels"
    params = {:title => "a new fantastic worksheet", :owner => @user, 
      :problem_levels_info => level_quantity_specs}
    MathProblem.expects(:all).with(:limit => last_count, :conditions => {:problem_level_id => type_level_last.id}).returns(problems_from_first_level)
    MathProblem.expects(:all).with(:limit => first_count, :conditions => {:problem_level_id => type_level_first.id}).returns(problems_from_last_level)
    worksheet = @builder.build(params)
    
    assert_difference('WorksheetProblem.count', expect_problem_count) do
      worksheet.save
    end
    
    assert_equal expect_problem_count, worksheet.math_problems.count
  end
  
  test "nested_worksheet_problem_parameters" do
    mp1 = math_problems(:simple_monomial_problem_03)
    mp2 = math_problems(:medium_monomial_problem_01)
    @builder.instance_variable_set(:@problems_to_add, [mp1, mp2])
    expected_problem_parameters = {"0" => {:math_problem_id => mp1.id, :problem_number => 1}, "1" => {:math_problem_id => mp2.id, :problem_number => 2}}
    assert_equal expected_problem_parameters, @builder.send("nested_worksheet_problem_parameters")
  end
end