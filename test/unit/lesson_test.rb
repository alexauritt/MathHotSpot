require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "lesson fixtures work like they should" do
    assert_equal 2, lessons(:dividing_monomials_lesson).section 
  end
  
  test "template_count" do
    lesson = Lesson.new
    num_instances = 4
    num_instances.times do
      lesson.math_problem_templates << MathProblemTemplate.new
    end
    
    assert_equal num_instances, lesson.template_count
  end

end
