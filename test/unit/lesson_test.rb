require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  def setup
    @lesson = Lesson.new
  end
  
  test "lesson fixtures work like they should" do
    assert_equal 2, lessons(:dividing_monomials_lesson).section 
  end
  
  test "template_count" do
    lesson = Lesson.new
    num_instances = 4
    num_instances.times do
      lesson.problem_types << ProblemType.new
    end
    
    assert_equal num_instances, lesson.template_count
  end
  
  test "subject_title returns empty string if no subject is specified" do
    assert_equal "", Lesson.new.subject_title
  end
  
  test "subject_title delegates to subject if present" do
    the_title = "asdfasdf"
    @lesson.subject = Subject.new
    @lesson.subject.expects(:title).returns(the_title)
    assert_equal the_title, @lesson.subject_title
  end

end
