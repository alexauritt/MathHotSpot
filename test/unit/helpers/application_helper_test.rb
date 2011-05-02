require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  test "display_difficulty" do
    level = ProblemLevel.new(:difficulty => 10)
    assert_equal "Difficulty: 10", display_difficulty(level)
  end
  
  test "display_difficulty blank if no difficulty set on level" do
    level = ProblemLevel.new
    assert_equal MathHotSpotErrors::Message::NO_DIFFICULTY_LEVEL, display_difficulty(level)
  end

end