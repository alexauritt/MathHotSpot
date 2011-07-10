require 'test_helper'
require 'mocha'

class ProblemTypeTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
    @standard_problem_type_params = { :owner_id => users(:testuser).id, 
      :category_id => categories(:polynomials).id, :title => 'This is a Problem Type'}
    @problem_type = ProblemType.new(@standard_problem_type_params)
    @level = @problem_type.problem_levels.build
    @level2 = @problem_type.problem_levels.build
  end

  test "instruction_text delegates to associated instruction instance" do
    instruction_text = "do this thing"
    @problem_type.build_instruction(:description => instruction_text)
    assert_equal instruction_text, @problem_type.instruction_text
  end
  
  test "instruction_text returns error msg if instruction not defined" do
    assert_equal MathHotSpotErrors::Message::NO_INSTRUCTIONS, ProblemType.new.instruction_text
  end
      
  test "use display mode by default" do
    assert ProblemType.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = ProblemType.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  
  test "demo_problem delegates to first problem_level.demo_problem if possible" do
    demo_math_prob = mock
    @level.expects(:empty?).returns(false)
    @level.expects(:demo_problem).returns(demo_math_prob)
    assert_equal demo_math_prob, @problem_type.demo_problem
  end
  
  test "demo_problem returns a problem from second level if first level has no math problems" do
    empty_problem = MathHotSpotErrors::EmptyProblem
    @level.expects(:empty?).returns(true)
    @level2.expects(:empty?).returns(false)
    @level2.expects(:demo_problem).returns(empty_problem)
    assert_equal empty_problem, @problem_type.demo_problem
  end
  
  test "demo_problem returns empty math problem if all levels are empty" do
    empty_problem = ProblemType.empty_problem
    @level.expects(:empty?).returns(true)
    @level2.expects(:empty?).returns(true)
    assert_equal empty_problem, @problem_type.demo_problem
  end
  
  test "demo_problem returns empty math problem if problem type has no levels" do
    empty_problem_type = ProblemType.new
    assert_equal MathHotSpotErrors::EmptyProblem, empty_problem_type.demo_problem
  end
  
  test "problem_count" do
    @level.stubs(:math_problems).returns([mock,mock])
    @level2.stubs(:math_problems).returns([mock,mock,mock])
    assert_equal 5, @problem_type.problem_count
  end
  
  test "level_count" do
    assert_equal 2, @problem_type.level_count
  end
    
  test "lowest_available_level_number" do
    prob_type = ProblemType.new
    [1,2,3,4,7].each do |level_number|
      prob_type.problem_levels.build(:level_number => level_number)
    end
    assert_equal 5, prob_type.lowest_available_level_number
  end

  test "lowest_available_level_number take 2" do
    prob_type = ProblemType.new
    [2,33].each do |level_number|
      prob_type.problem_levels.build(:level_number => level_number)
    end
    assert_equal 1, prob_type.lowest_available_level_number
  end
  
  test "lowest_available_level_number take 3" do
    prob_type = ProblemType.new
    [1,2,3,4,5].each do |level_number|
      prob_type.problem_levels.build(:level_number => level_number)
    end
    assert_equal 6, prob_type.lowest_available_level_number
  end
  
  test "lowest_available_level_number with no current levels" do
    prob_type = ProblemType.new
    assert_equal 1, prob_type.lowest_available_level_number
  end
  
  test "new problem type created with nested problem level" do
    params = {:problem_type => {:title => "Best problem type ever created", :owner => users(:testuser), 
      :category => categories(:polynomials), 
      :problem_levels_attributes => [{:level_number => 10}]
    }}
    
    assert_difference('ProblemType.count') do
      assert ProblemType.create(params[:problem_type])
    end
    
  end
  
  test "new problem level created when nested in math problem template" do
    params = {:problem_type => {:title => "utterly fantastic problem type", :owner => users(:testuser), 
      :category => categories(:polynomials),  :problem_levels_attributes => [{:level_number => 10}]
    }}
  
    assert_difference('ProblemLevel.count') do
      assert ProblemType.create(params[:problem_type]), @problem_type.errors.to_s
    end    
  end
  
  test "second problem invalid if names different but permalinks identical" do
    first_title = "a nice title"
    second_title = "a       nice title"
    
    assert_problem_created_with_first_title_but_second_fails(first_title, second_title)
  end
  
  test "search" do
    results = ProblemType.search("Monomial Fraction Simplifcation Assume No Zero Denominator")
    assert results.include?(problem_types(:simp_no_zero_problem_type)), "Problem Type not found."
    assert_equal 1, results.length, "Exactly one result expected in search, but #{results.length} item(s) found"
  end
  
  test "search (title) is case insensitive" do
    pt = ProblemType.create(:title => "Fraction Multiplication", :owner => users(:testuser), 
      :category => categories(:polynomials))
    results = ProblemType.search("fraction MULTIPLicATIOn")
    assert results.include?(pt), "Problem Type not found with case insensitive search (by title)"
  end
  
  test "search (tags) is case insensitive" do
    params = @standard_problem_type_params.merge({:tag_list => "Candy, chocolate"})
    # puts "new params are #{params}"
    pt = ProblemType.create(params)
    results = ProblemType.search("candy, Chocolate")
    assert results.include?(pt)
  end
    
  test "empty_problem returns math problems with blank string as answer markup" do
    assert_equal "", ProblemType.empty_problem.answer_markup
  end
  
  test "destory fails if problem type has existing levels" do
    assert_equal false, @problem_type.destroy, "Can't destroy this problem type -- It has LEVELS!"
  end
  
  test "destroy succeeds if no levels exists" do
    problem_type = ProblemType.new
    assert problem_type.destroy, "ProblemType with no levels successfully destroyed"
  end
  
  test "empty?" do
    problem_type = ProblemType.new
    assert problem_type.empty?
  end
  
  test "empty? false if levels present" do
    assert_equal false, @problem_type.empty?
  end  

  test "category_with_subject delegates to category" do
    problem_type = ProblemType.new
    problem_type.build_category
    expected_subject_string = "A Subject: A title"
    problem_type.category.expects(:name).returns(expected_subject_string)
    assert_equal expected_subject_string, problem_type.category_with_subject
  end
  
  private
  
  def assert_problem_created_with_first_title_but_second_fails(first_title, second_title)
    title = first_title

    params = {:problem_type => {:title => title, :owner => users(:testuser), 
      :category => categories(:polynomials), :instruction => instructions(:simplify), 
      :problem_levels_attributes => [{:level_number => 10}]
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
