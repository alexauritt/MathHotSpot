require 'test_helper'
require 'integration_test_helper'

class LessonsAndProblemTypesTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers
  include ActionController::IntegrationTest::Lessony
  include ActionController::IntegrationTest::ProblemTypeSearchy

  setup do
    DatabaseCleaner.start
    @user = Factory(:user_with_lesson)
    @lesson = @user.lessons.first
    sign_in_as @user
  end

  test "search for problem type for lesson" do
    visit my_lessons_path

    within('#my-lessons') do
      click_link(@lesson.title)
    end
    
    click_link "Find a Problem Type for this Lesson"
    
    assert_current_path new_problem_types_search_path
    assert_current_lesson_displayed(@lesson.title)
    assert_problem_type_search_forms_displayed
  end
  
  test "add problem type to lesson" do
    different_problem_type = Factory.create(:problem_type, :title => "Exponents of Imaginary Numbers", :owner => @user)
    assert_problem_type_displayed_in_lesson_view(different_problem_type, false)
    
    visit lesson_path(@lesson)
    
    click_link("Find a Problem Type for this Lesson")
    assert_current_path new_problem_types_search_path
    click_link(different_problem_type.title)
    
    assert_current_path problem_type_path(different_problem_type)
    assert_current_lesson_displayed(@lesson.title)
    
    click_button("Add Problem Type")
    
    assert_current_path lesson_path(@lesson)
    
    assert_problem_type_displayed_in_lesson_view(different_problem_type)
  end
  
  teardown do
    DatabaseCleaner.clean
  end

end
