require 'test_helper'
require 'mocha'

class MathProblemTest < ActiveSupport::TestCase

  def setup
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

  test "rougue_problems" do
    rougues = MathProblem.rougue_problems
    assert_not_nil rougues
    assert rougues.size != 0
  end
  
  test "all problems are either rougue or grouped" do
    rougues = MathProblem.rougue_problems
    grouped = MathProblem.grouped_problems
    assert_equal MathProblem.count, rougues.size + grouped.size
  end
  
  test "display_mode? returns true (default) if no math_problem_template defined" do
    assert MathProblem.new.display_mode?
  end
  
  test "strip_excess_tags" do
    input_from_math_type = "<math display='block'><semantics><mrow>        <msqrt><mrow><msup><mi>a</mi>      <mn>2</mn></msup>      <mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow><annotation encoding='MathType-MTEF'>     MathType@MTEF@5@5@+=faaagaart1ev2aaaKnaaaaWenf2ys9wBH5garuavP1wzZbqedmvETj2BSbqefm0B1jxALjharqqtubsr4rNCHbGeaGqiVu0Je9sqqrpepC0xbbL8FesqqrFfpeea0xe9Lq=Jc9vqaqpepm0xbba9pwe9Q8fs0=yqaqpepae9pg0FirpepeKkFr0xfr=xfr=xb9Gqpi0dc9adbaqaaeGaciGaaiaabeqaamaabaabaaGcbaWaaOaaaeaacaWGHbWaaWbaaSqabeaacaaIYaaaaOGaey4kaSIaamOyamaaCaaaleqabaGaaGOmaaaaaeqaaOGaey4kaSIaaGzaVpaalaaabaGaamOBaiaacgcaaeaacaWGYbGaaiyiamaabmaabaGaamOBaiabgkHiTiaadkhaaiaawIcacaGLPaaacaGGHaaaaaaa@3D6C@</annotation></semantics></math>"
    all_striped_down = "<mrow><msqrt><mrow><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup></mrow></msqrt><mo>+</mo><mtext>&#x200B;</mtext><mfrac><mrow><mi>n</mi><mo>!</mo></mrow><mrow><mi>r</mi><mo>!</mo><mrow><mo>(</mo><mrow><mi>n</mi><mo>&#x2212;</mo><mi>r</mi></mrow><mo>)</mo></mrow><mo>!</mo></mrow></mfrac></mrow>"
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
    all_striped_down = "<mrow><mfrac><mi>x</mi><mn>2</mn></mfrac></mrow>"
    problem = MathProblem.new(:question_markup => input_from_math_type)
    problem.send(:strip_excess_tags)
    
    assert_equal all_striped_down, problem.question_markup
  end
  
  private
  def stub_math_problem_order_to_return_sorted_list(ordered_problem_list)
    MathProblem.stubs(:grouped_problems).returns(ordered_problem_list)
  end  
end