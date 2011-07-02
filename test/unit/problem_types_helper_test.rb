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
  
  test "delete level returns nothing if level has math problems" do
    level = ProblemLevel.new(:level_number => '23')
    level.build_problem_type(:title => "abra")
    level.math_problems.build(:question_markup => "some markup", :answer_markup => "some answer")
    assert_equal "", delete_level(level)
  end
  
  test "delete level returns delete link if level is empty" do
    level = ProblemLevel.new(:level_number => '17')
    level.build_problem_type(:title => 'my prob type')
    destroy_link = link_to('Delete Level', '/problem_types/my-prob-type/problem_levels/17', :confirm => 'Are you sure?', :method => :delete)
    assert_equal destroy_link, delete_level(level)
  end
  
  test "delete_problem_type_link returns nothing if problem type has levels" do
    @problem_type.problem_levels.build
    assert_equal "", delete_problem_type_link_if_empty(@problem_type)
  end
  
  test "delete_problem_type_link returns link if problem type is empty" do
    @problem_type.title = "wkrp"
    destroy_link = render(:partial => 'problem_types/delete_problem_type', :locals => {:type => @problem_type})
    assert_equal destroy_link, delete_problem_type_link_if_empty(@problem_type)
  end
  
  test "empty_problem_type_message" do
    assert_equal MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE, empty_problem_type_message
  end
end