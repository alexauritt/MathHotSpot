require 'test_helper'

class CoreLessonProblemTypesControllerTest < AuthenticatingControllerTestCase
  # Replace this with your real tests.
  def setup
    @lesson = Factory.create(:lesson, :owner => users(:testuser))
    @problem_type = Factory.create(:problem_type)
    @attributes = Factory.attributes_for(:core_lesson_problem_type, :lesson => @lesson, :problem_type => @problem_type)
  end

  test "create" do
    
    assert_difference('CoreLessonProblemType.count') do
      post :create, :core_lesson_problem_type => @attributes
    end
    
    assert_redirected_to lesson_path(@lesson)
  end
  
  test "create fails gracefully when problem type already present in lesson" do
    core_already_in_db = Factory.create(:core_lesson_problem_type, :lesson => @lesson, :problem_type => @problem_type)
    assert_no_difference('CoreLessonProblemType.count') do
      post :create, :core_lesson_problem_type => core_already_in_db.attributes
    end
  end
end
