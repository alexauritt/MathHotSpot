require 'test_helper'
require 'integration_test_helper'

class CreateAndModifyLessonsTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers
  include ActionController::IntegrationTest::Lessony

  setup do
    DatabaseCleaner.start
    @user = Factory(:user_with_lesson)
    sign_in_as @user
  end
  
  test "Create a vanilla Algebra Lesson" do
    lesson_name = 'My First Lesson'
    
    click_link('dashboard')
    click_link('Create a new Lesson')

    assert_current_path new_lesson_path

    fill_in 'Title', :with => lesson_name
    click_button('Create Lesson')
    
    assert_current_path newly_created_lesson_path_with_name(lesson_name)
  end
  
  test "delete a pre-existing lesson" do
    lesson_to_delete = @user.lessons.first
    dead_lesson_title = lesson_to_delete.title
    click_link('dashboard')

    within('#my-lessons') do
      click_link(lesson_to_delete.title)
    end    
    assert_current_path lesson_path(lesson_to_delete)
    
    click_link('Edit')
    click_link('Delete Lesson')
    
    assert_current_path my_lessons_path
    assert_lesson_not_displayed(dead_lesson_title)
  end

  private
  def newly_created_lesson_path_with_name(lesson_name)
    new_lesson = Lesson.find_by_title(lesson_name)
    lesson_path(new_lesson)
  end
  
  teardown do
    DatabaseCleaner.clean
  end
         
end
