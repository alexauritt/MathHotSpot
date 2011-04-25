require 'test_helper'

class MathProblemTemplatesHelperTest < ActionView::TestCase
  
  def setup
    @template = MathProblemTemplate.new
  end
  
  test "level_count_msg multiple" do
    @template.stubs(:level_count).returns(7)
    assert_equal "7 Levels", level_count_msg(@template)
  end
  
  test "level_count_msg singular" do
    @template.stubs(:level_count).returns(1)
    assert_equal "1 Level", level_count_msg(@template)
  end
  
  test "level_count_msg zip" do
    @template.stubs(:level_count).returns(0)
    assert_equal "0 Levels", level_count_msg(@template)
  end

  test "problem_count_msg multiple" do
    @template.stubs(:problem_count).returns(7)
    assert_equal "7 Problems", problem_count_msg(@template)
  end
  
  test "problem_count_msg singular" do
    @template.stubs(:problem_count).returns(1)
    assert_equal "1 Problem", problem_count_msg(@template)
  end
  
  test "problem_count_msg zip" do
    @template.stubs(:problem_count).returns(0)
    assert_equal "0 Problems", problem_count_msg(@template)
  end
  
end