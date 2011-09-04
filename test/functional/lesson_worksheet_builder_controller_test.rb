require 'test_helper'

class LessonWorksheetBuilderControllerTest < AuthenticatingControllerTestCase
  test "new" do
    lesson = lessons(:dividing_monomials_lesson)
    type1 = problem_types(:dividing_monomials_problem_type)
    type2 = problem_types(:find_gcf_of_monomials_problem_type)
    all_lesson_levels = type1.problem_levels + type2.problem_levels
    
    Lesson.expects(:find).with(lesson.to_param).returns(lesson)
    lesson.expects(:problem_types).returns([type1, type2])
    lesson.expects(:empty?).returns(false)
    
    get :new, :id => lesson.to_param
    
    assert assigns(:lesson)
    assert_response :success
  end
  
  test "new redirects to lesson page if lesson is empty" do
    lesson = Factory.create(:lesson, :owner => User.first)
    
    get :new, :id => lesson.to_param
    
    assert_redirected_to lesson_path(lesson)
  end
end
