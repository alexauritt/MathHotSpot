require 'test_helper'

class MathProblemsHelperTest < ActionView::TestCase
  def setup
    @lesson = Lesson.new
    @question_markup = "<mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac>"
    @answer_markup = "some answer markup"
    @problem = MathProblem.new(:question_markup => @question_markup, :answer_markup => @answer_markup)
  end
  
  test "display_mathml_question does not wraps math markup if display mode is true (default)" do
    assert_equal(@problem.question_markup, display_mathml_question(@problem))
  end

  test "display_mathml_answer does not wraps math markup if display mode is true (default)" do
    assert_equal(@problem.answer_markup, display_mathml_answer(@problem))
  end

  test "display_mathml_question wraps in p if display_mode is false" do
    @problem.stubs(:display_mode?).returns(false)
    expected_output = "<p class='inline_math'>" + @question_markup + "</p>"
    assert_equal(expected_output, display_mathml_question(@problem))
  end
  
  test "display_mathml_question displays default msg if it receives null math problem" do
    assert_equal(MathHotSpotErrors::Message::NO_SAMPLE_MATH_PROBLEM_FOUND, display_mathml_question(nil))
  end
    
end
