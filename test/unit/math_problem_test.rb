require 'test_helper'
require 'mocha'

class MathProblemTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  include RightRabbitErrors
  
  def setup
    @math_problem = MathProblem.new
    @another_problem = MathProblem.new
    @yet_another_problem = MathProblem.new
    @three_problems = [@math_problem, @another_problem, @yet_another_problem]
    @level = @math_problem.build_problem_level
    @problem_type = @level.build_problem_type
  end
    
  test "group_by_problem_level returns number of groups equal number of levels of existent math problems" do
    all_levels = MathProblem.all.map { |prob| prob.problem_level }
    all_levels.uniq!
    active_levels = all_levels.uniq.reject { |level| level.empty? }
    groups = MathProblem.group_by_problem_level    
    assert_equal active_levels.size, groups.size
  end
  
  test "replace math problem returns different problem with same problem_type" do
    third_problem = MathProblem.new
    MathProblem.expects(:find_all_by_problem_level_id).with(@level.id).returns([@math_problem, @another_problem])
    replacement = @math_problem.find_problem_from_same_level
    assert_equal(@another_problem, replacement)
  end
  
  test "find_problem_from_same_level raises if specified problem's problem_type can not be found" do
    MathProblem.expects(:find_all_by_problem_level_id).with(@level.id).returns([])
    assert_raise ActiveRecord::RecordNotFound do
      @math_problem.find_problem_from_same_level
    end
  end

  test "find_problem_from_same_level returns problem not being replaced and not exluded" do
    MathProblem.expects(:find_all_by_problem_level_id).with(@level.id).returns(@three_problems)
    replacement = @math_problem.find_problem_from_same_level({:exclude => [@another_problem] })
    assert_equal @yet_another_problem, replacement
  end

  test "find_problem_from_same_level raises if problem is one of a kind" do
    MathProblem.expects(:find_all_by_problem_level_id).with(@level.id).returns([@math_problem])
    assert_raise UniqueProblemError do
      @math_problem.find_problem_from_same_level
    end
  end
  
  test "find_problem_from_same_level raises if all available problems excluded" do
    MathProblem.expects(:find_all_by_problem_level_id).with(@level.id).returns([@math_problem, @another_problem])
    assert_raise NoSimilarProblemsRemainingError do
      @math_problem.find_problem_from_same_level({:exclude => [@another_problem]})
    end
  end
      
  test "display_mode? returns true (default) if no problem_level defined" do
    assert MathProblem.new.display_mode?
  end
  
  test "strip_excess_tags" do
    input_from_math_type = "<math display='block'><semantics><mrow>        <msqrt><mrow><msup><mi>a</mi>      <mn>2</mn></msup>      <mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow><annotation encoding='MathType-MTEF'>     MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaOaaaeaacaWGHbWaaWbaaSqabeaacaaIYaaaaOGaey4kaSIaamOyamaaCaaaleqabaGaaGOmaaaaaeqaaOGaey4kaSIaaGzaVpaalaaabaGaamOBaiaacgcaaeaacaWGYbGaaiyiamaabmaabaGaamOBaiabgkHiTiaadkhaaiaawIcacaGLPaaacaGGHaaaaaaa@3D6C@</annotation></semantics></math>"
    all_striped_down = "<math display='block'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => input_from_math_type, :answer_markup => 'some answer markup')
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.question_markup
  end
  
  test "removes mathml xmlns and adds display=block for question markup" do
    input_from_math_type = "<math xmlns='http://www.w3.org/1998/Math/MathML'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    all_striped_down = "<math display='block'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => input_from_math_type, :answer_markup => input_from_math_type)
    problem.send(:replace_xmlns_with_display_block)

    assert_equal all_striped_down, problem.question_markup
  end

  test "removes mathml xmlns from answer_markup and adds display=block" do
    input_from_math_type = "<math xmlns='http://www.w3.org/1998/Math/MathML'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    all_striped_down = "<math display='block'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => "some question stuff here", :answer_markup => input_from_math_type)
    problem.send(:replace_xmlns_with_display_block)

    assert_equal all_striped_down, problem.answer_markup    
  end
    
  test "strip_excess_tags removes newlines from question markup" do
    input_from_math_type = "<math display='block'>
     <semantics>
      <mrow>
       <mfrac>
        <mi>x</mi>
        <mn>2</mn>
       </mfrac>

      </mrow>
     <annotation encoding='MathType-MTEF'>
     MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWG4baabaGaaGOmaaaaaaa@2FDB@</annotation>
     </semantics>
    </math>
    "
    all_striped_down = "<math display='block'><mrow><mfrac><mi>x</mi><mn>2</mn></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => input_from_math_type, :answer_markup => 'some answer markup')
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.question_markup
  end

  test "strip_excess_tags removes newlines from answer markup" do
    input_from_math_type = "<math display='block'>
     <semantics>
      <mrow>
       <mfrac>
        <mi>x</mi>
        <mn>2</mn>
       </mfrac>

      </mrow>
     <annotation encoding='MathType-MTEF'>
     MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaSaaaeaacaWG4baabaGaaGOmaaaaaaa@2FDB@</annotation>
     </semantics>
    </math>
    "
    all_striped_down = "<math display='block'><mrow><mfrac><mi>x</mi><mn>2</mn></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => "some question markup", :answer_markup => input_from_math_type)
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.answer_markup
  end

  test "strip_excess_tags and replace_xmlns_with_display_block don't choke if answer_markup is nil" do
    problem = MathProblem.new(:question_markup => "some question markup")

    assert_nothing_raised do
      problem.send(:strip_excess_tags)
      problem.send(:replace_xmlns_with_display_block)
    end
  end
  
  test "instruction when problem_level is nil returns default message" do
    assert_equal MathProblem::DEFAULT_INSTRUCTION, MathProblem.new.instruction
  end
  
  test "instruction_description returns expected text from level" do
    expected_msg = "this is the expected message"
    instruction = Instruction.new(:description => expected_msg)
    prob = MathProblem.new
    level = prob.build_problem_level
    level.expects(:instruction).returns(instruction)
    
    assert_equal expected_msg, prob.instruction_description
  end
  
  test "siblings with no params returns all siblings" do
    problem_level = ProblemLevel.new
    4.times {problem_level.math_problems.build}
    problem = problem_level.math_problems.build
    problem.problem_level = problem_level
    expected_siblings = problem_level.math_problems[0..3]
    
    assert_equal problem_level, problem.problem_level, "Looks as through level wasn't set"
    assert_equal expected_siblings, problem.siblings
  end
  
  test "siblings 3 returns only 3 siblings" do
    problem_level = ProblemLevel.new
    4.times {problem_level.math_problems.build}
    problem = problem_level.math_problems.build
    problem.problem_level = problem_level

    assert_equal 3, problem.siblings(3).count
  end
  
  test "math problem is valid without if problem_level nil" do
    problem = MathProblem.new(:question_markup => 'some markup', :answer_markup => 'some more markup', :owner => User.first)
    assert problem.valid?
  end
  
  test "math problem invalid if problem_level_id specified but not in db" do
    level_id = 666
    ProblemLevel.expects(:exists?).with(level_id).returns(false)
    problem = Factory.build(:math_problem, :problem_level_id => level_id)
    
    assert_equal false, problem.valid?
  end
    
  test "math problem is invalid without owner" do
    problem = MathProblem.new(:question_markup => 'some markup', :answer_markup => 'some more markup', :problem_level => problem_levels(:dividing_monomials_level_01))
    assert_equal false, problem.valid?
  end
  
  test "sibling_available? returns true with one sibling found and no restrictions" do
    level_id = 987
    @level.stubs(:id).returns(level_id)

    MathProblem.expects(:find_all_by_problem_level_id).with(level_id).returns(@three_problems)

    assert @math_problem.sibling_available?
  end
  
  test "sibling_available returns true if one option left" do
    level_id = 987
    @level.stubs(:id).returns(level_id)

    MathProblem.expects(:find_all_by_problem_level_id).with(level_id).returns(@three_problems)

    assert @math_problem.sibling_available?(:exclude => [@another_problem])    
  end
  
  test "sibling_available returns false if all options are excluded" do
    level_id = 987
    @level.stubs(:id).returns(level_id)

    MathProblem.expects(:find_all_by_problem_level_id).with(level_id).returns(@three_problems)

    assert_equal false, @math_problem.sibling_available?(:exclude => [@another_problem, @yet_another_problem])
  end
  
  test "math problems with specified problem levels are considered classified" do
    assert @math_problem.classified?, "Math Problem should be classified because problem_level is specified"
  end
  
  test "math problem with no problem_level are NOT classified" do
    problem = Factory.build(:math_problem, :problem_level_id => nil)
    assert_equal false, problem.classified?
  end
  
  private
  def stub_math_problem_order_to_return_sorted_list(ordered_problem_list)
    MathProblem.stubs(:grouped_problems).returns(ordered_problem_list)
  end  
end