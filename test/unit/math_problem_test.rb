require 'test_helper'
require 'mocha'

class MathProblemTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  
  def setup
    @math_problem = MathProblem.new
    @another_problem = MathProblem.new
    @yet_another_problem = MathProblem.new
    @three_problems = [@math_problem, @another_problem, @yet_another_problem]
    @template = @math_problem.build_math_problem_template
    @template.stubs(:id).returns(666)
  end
  
  test "group_all_by_problem_template" do
    @first = MathProblem.new
    @second = MathProblem.new
    @third = MathProblem.new
    @fourth = MathProblem.new
    first_template = mock
    second_template = mock
    @first.stubs(:math_problem_template).returns(first_template)
    @second.stubs(:math_problem_template).returns(second_template)
    @third.stubs(:math_problem_template).returns(first_template)
    @fourth.stubs(:math_problem_template).returns(first_template)
    stub_math_problem_order_to_return_sorted_list([@first, @third, @fourth, @second])
    groups = MathProblem.group_all_by_template
    assert_equal 2, groups.size
    assert_equal 3, groups.first.size
  end

  test "replace math problem returns different problem with same template" do
    third_problem = MathProblem.new
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@template.id).returns([@math_problem, @another_problem])
    replacement = @math_problem.find_replacement
    assert_equal(@another_problem, replacement)
  end
  
  test "find_replacement raises if specified problem's template can not be found" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@template.id).returns([])
    assert_raise ActiveRecord::RecordNotFound do
      @math_problem.find_replacement
    end
  end

  test "find_replacement returns problem not being replaced and not exluded" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@template.id).returns(@three_problems)
    replacement = @math_problem.find_replacement({:exclude => [@another_problem] })
    assert_equal @yet_another_problem, replacement
  end

  test "find_replacement raises if problem is one of a kind" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@template.id).returns([@math_problem])
    assert_raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR do
      @math_problem.find_replacement
    end
  end
  
  test "find_replacement raises if all available problems excluded" do
    MathProblem.expects(:find_all_by_math_problem_template_id).with(@template.id).returns([@math_problem, @another_problem])
    assert_raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING do
      @math_problem.find_replacement({:exclude => [@another_problem]})
    end
  end
  
  test "rogue_problems" do
    rogues = MathProblem.rogue_problems
    assert_not_nil rogues
    assert rogues.size != 0
  end
  
  test "all problems are either rogue or grouped" do
    rogues = MathProblem.rogue_problems
    grouped = MathProblem.grouped_problems
    assert_equal MathProblem.count, rogues.size + grouped.size
  end
  
  test "display_mode? returns true (default) if no math_problem_template defined" do
    assert MathProblem.new.display_mode?
  end
  
  test "strip_excess_tags" do
    input_from_math_type = "<math display='block'><semantics><mrow>        <msqrt><mrow><msup><mi>a</mi>      <mn>2</mn></msup>      <mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow><annotation encoding='MathType-MTEF'>     MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaOaaaeaacaWGHbWaaWbaaSqabeaacaaIYaaaaOGaey4kaSIaamOyamaaCaaaleqabaGaaGOmaaaaaeqaaOGaey4kaSIaaGzaVpaalaaabaGaamOBaiaacgcaaeaacaWGYbGaaiyiamaabmaabaGaamOBaiabgkHiTiaadkhaaiaawIcacaGLPaaacaGGHaaaaaaa@3D6C@</annotation></semantics></math>"
    all_striped_down = "<math display='block'><mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow></math>"
    problem = MathProblem.new(:question_markup => input_from_math_type)
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.question_markup
  end
  
  test "strip_excess_tags removes newlines" do
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
    problem = MathProblem.new(:question_markup => input_from_math_type)
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.question_markup
  end
  
  private
  def stub_math_problem_order_to_return_sorted_list(ordered_problem_list)
    MathProblem.stubs(:grouped_problems).returns(ordered_problem_list)
  end  
end