require 'test_helper'
require 'mocha'

class MathHotSpotErrorsTest < ActionView::TestCase
  test "message.display" do
    msg = MathHotSpotErrors::Message.display(MathHotSpotErrors::ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR.new)
    assert_equal MathHotSpotErrors::Message::UNIQUE, msg 
  end
end