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
    
    assert_current_path search_problem_types_path
    assert_current_lesson_displayed(@lesson.title)
    assert_problem_type_search_forms_displayed
  end
  
  test "add problem type to lesson" do
    pending "to do"
  end
  
  teardown do
    DatabaseCleaner.clean
  end

end
