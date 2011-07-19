require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  def setup
    @lesson = Lesson.new
  end
      
  test "topic_name returns empty string if no subject is specified" do
    assert_equal "", Lesson.new.topic_name
  end
  
  test "topic_name delegates to subject if present" do
    the_title = "asdfasdf"
    lesson = Lesson.new
    lesson.subject = Subject.new
    lesson.subject.expects(:title).returns(the_title)
    assert_equal the_title, lesson.topic_name
  end
  
  test "problem_type_count" do
    lesson = Lesson.new
    4.times { lesson.problem_types.build }
    Rails.logger.info "pts #{lesson.problem_types}"
    assert_equal 4, lesson.problem_type_count
  end
  
  test "new_problem_type" do
    problem_type = Factory.create(:problem_type)
    assert_difference('@lesson.problem_type_count') do
      @lesson.new_problem_type = problem_type.id
    end
  end

end
