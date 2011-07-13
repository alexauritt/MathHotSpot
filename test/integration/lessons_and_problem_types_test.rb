require 'test_helper'
require 'integration_test_helper'

class LessonsAndProblemTypesTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers
  include ActionController::IntegrationTest::Lessony

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
    
    assert_current_path new_lessons_problem_type_search_path(@lesson)
  end
  
  teardown do
    DatabaseCleaner.clean
  end

end
