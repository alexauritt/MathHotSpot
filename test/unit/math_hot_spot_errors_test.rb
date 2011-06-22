require 'test_helper'
require 'mocha'

class MathHotSpotErrorsTest < ActionView::TestCase
  test "message.display" do
    msg = MathHotSpotErrors::Message.display(MathHotSpotErrors::ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR.new)
    assert_equal MathHotSpotErrors::Message::UNIQUE, msg 
  end
  
  test "EmptyProblem has error message for question markup" do
    assert_respond_to MathHotSpotErrors::EmptyProblem, :question_markup
  end
  
  test "EmptyProblem returns empty string for answer markup" do
    assert_equal "", MathHotSpotErrors::EmptyProblem.answer_markup
  end
  
  test "EmptyProblem display_mode returns false" do
    assert !MathHotSpotErrors::EmptyProblem.display_mode?
  end
end