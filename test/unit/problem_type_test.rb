require 'test_helper'
require 'mocha'

class ProblemTypeTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @problem_type = ProblemType.new
    @level = @problem_type.problem_levels.build
    @level2 = @problem_type.problem_levels.build
  end
      
  test "use display mode by default" do
    assert ProblemType.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = ProblemType.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  
  test "demo problem" do
    @level.stubs(:demo_problem).returns(MathProblem.new)
    assert_instance_of MathProblem, @problem_type.demo_problem
  end
  
  test "demo_problem returns empty problem when template has no levels defined" do
    @problem_type.demo_problem
  end
  
  test "problem_count" do
    @level.stubs(:math_problems).returns([mock,mock])
    @level2.stubs(:math_problems).returns([mock,mock,mock])
    assert_equal 5, @problem_type.problem_count
  end
  
  test "level_count" do
    assert_equal 2, @problem_type.level_count
  end
  
  test "new template created with nested problem level" do
    params = {:problem_type => {:title => "Best problem type ever created", :lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
    
    assert_difference('ProblemType.count') do
      assert ProblemType.create(params[:problem_type])
    end
    
  end
  
  test "new problem level created when nested in math problem template" do
    params = {:problem_type => {:title => "utterly fantastic problem type", :lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}
  
    assert_difference('ProblemLevel.count') do
      assert ProblemType.create(params[:problem_type]), @problem_type.errors.to_s
    end    
  end
  
  test "second problem invalid if names different but permalinks identical" do
    first_title = "a nice title"
    second_title = "a       nice title"
    
    assert_first_problem_saves_but_second_fails(first_title, second_title)
  end
  
  test "search" do
    results = ProblemType.search("Monomial Fraction Simplifcation Assume No Zero Denominator")
    assert results.include?(problem_types(:simp_no_zero_problem_type)), "Problem Type not found."
    assert_equal 1, results.length, "Exactly one result expected in search, but #{results.length} item(s) found"
  end
  
  test "search (title) is case insensitive" do
    pt = ProblemType.create(:title => "Fraction Multiplication")
    results = ProblemType.search("fraction MULTIPLicATIOn")
    assert results.include?(pt), "Problem Type not found with case insensitive search (by title)"
  end
  
  test "search (tags) is case insensitive" do
    pt = ProblemType.create(:tag_list => "Candy, chocolate", :title => "Hershey Bar")
    results = ProblemType.search("candy, Chocolate")
    assert results.include?(pt)
  end

  private
  
  def assert_first_problem_saves_but_second_fails(first_title, second_title)
    title = first_title

    params = {:problem_type => {:title => title, :lesson_id => 8, :instruction_id => 10, 
      :problem_levels_attributes => [{:difficulty => 10}]
    }}

    assert_difference('ProblemType.count') do
      assert ProblemType.create(params[:problem_type]), @problem_type.errors.to_s
    end
    
    title = second_title
    assert_no_difference('ProblemType.count') do
      assert ProblemType.create(params[:problem_type]), @problem_type.errors.to_s
    end
    
  end

end
