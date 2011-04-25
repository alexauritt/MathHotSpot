require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  test "display_difficulty" do
    level = ProblemLevel.new(:difficulty => 10)
    assert true
    assert_equal "Difficulty: 10", display_difficulty(level)
  end

end