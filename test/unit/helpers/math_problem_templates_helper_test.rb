require 'test_helper'

class ProblemTypesHelperTest < ActionView::TestCase
  
  def setup
    @problem_type = ProblemType.new
  end
  
  test "level_count_msg multiple" do
    @problem_type.stubs(:level_count).returns(7)
    assert_equal "7 Levels", level_count_msg(@problem_type)
  end
  
  test "level_count_msg singular" do
    @problem_type.stubs(:level_count).returns(1)
    assert_equal "1 Level", level_count_msg(@problem_type)
  end
  
  test "level_count_msg zip" do
    @problem_type.stubs(:level_count).returns(0)
    assert_equal "0 Levels", level_count_msg(@problem_type)
  end

  test "problem_count_msg multiple" do
    @problem_type.stubs(:problem_count).returns(7)
    assert_equal "7 Problems", problem_count_msg(@problem_type)
  end
  
  test "problem_count_msg singular" do
    @problem_type.stubs(:problem_count).returns(1)
    assert_equal "1 Problem", problem_count_msg(@problem_type)
  end
  
  test "problem_count_msg zip" do
    @problem_type.stubs(:problem_count).returns(0)
    assert_equal "0 Problems", problem_count_msg(@problem_type)
  end
  
  test "display_tag_list with no tags" do
    assert_equal "", display_tag_list(@problem_type)
  end
  
  test "display tag list" do
    @problem_type.tag_list = "Movies, Music, Coffee"
    assert_equal "Tags: <span class='tag'>Movies</span><span class='tag'>Music</span><span class='tag'>Coffee</span>", display_tag_list(@problem_type)
  end
end