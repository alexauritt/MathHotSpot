require 'test_helper'

class MathProblemsHelperTest < ActionView::TestCase
  def setup
    @input_markup = "<mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac>" 
    @template = MathProblemTemplate.new
    @problem = MathProblem.new(:question_markup => @input_markup, :math_problem_template => @template)
  end
  
  test "display_mathml does not wraps math markup if display mode is true (default)" do
    assert_equal(@problem.question_markup, display_mathml(@problem))
  end
  
  test "display_mathml wraps in p if display_mode is false" do
    @template.display_mode = false
    expected_output = "<p class='inline_math'>" + @input_markup + "</p>"
    assert_equal(expected_output, display_mathml(@problem))
  end  
end
