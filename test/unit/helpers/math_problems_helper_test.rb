require 'test_helper'

class MathProblemsHelperTest < ActionView::TestCase
  def setup
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
  
  test "problem_type_count should be zero" do
    @lesson = Lesson.new
    assert_equal "(Empty)", problem_type_count(@lesson)
  end
  
  test "problem_type_count should be 1" do    
    @lesson = Lesson.new
    @lesson.problem_types.build
    
    assert_equal "(1 problem type)", problem_type_count(@lesson)
  end

  test "problem_type_count should be 7" do
    @lesson = Lesson.new
    7.times { @lesson.problem_types.build }
    
    assert_equal "(7 problem types)", problem_type_count(@lesson)
  end
  
  
  
end
