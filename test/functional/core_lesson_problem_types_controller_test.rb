require 'test_helper'

class CoreLessonProblemTypesControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  test "create" do
    lesson = Factory.create(:lesson, :owner => users(:testuser) )
    problem_type = Factory.create(:problem_type)
    core_lesson_problem_type = Factory.build(:core_lesson_problem_type, :lesson => lesson, :problem_type => problem_type)
    
    assert_difference('CoreLessonProblemType.count') do
      post :create, :core_lesson_problem_type => core_lesson_problem_type.attributes
    end
    
    assert_redirected_to lesson_path(lesson)
    
    pending "user factory girl attr_for"
  end
  
  test "create fails gracefully when problem type is already in lesson" do
    pending "to do"
  end
  
  test "create fails gracefully when lesson id is invalid" do
    pending "to do"
  end
  
  test "create fails gracefully when problem_type id is invalid" do
    pending "to do"
  end
end
