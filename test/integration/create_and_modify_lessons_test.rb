require 'test_helper'
require 'integration_test_helper'

class CreateAndModifyLessonsTest < ActionDispatch::IntegrationTest

  def setup
    create_user_and_sign_in
  end

  test "Create a vanilla Algebra Lesson" do
    lesson_name = 'My First Lesson'
    
    click_link('My Dashboard')
    click_link('Create a new Lesson')

    assert_current_path new_lesson_path

    fill_in 'Title', :with => lesson_name
    click_button('Create Lesson')
    
    assert_current_path my_lessons_path    
    assert_lesson_displayed(lesson_name)    
  end

  # test "Create a generic Algebra Lesson and set the category" do
  # 
  #   @subject = Factory.create(:subject)
  #   @category = Factory.create(:category)
  # 
  #   lesson_name = 'My First Lesson'
  #   
  #   click_link('My Dashboard')
  #   click_link('Create a new Lesson')
  # 
  #   assert_equal new_lesson_path, current_path
  # 
  #   fill_in 'Title', :with => lesson_name
  #   select @category.title, :from => "Topic"
  #   click_button('Create Lesson')
  #   
  #   assert_equal my_lessons_path, current_path
  #   
  #   within('#my-lessons .topic-list .topic-title') do
  #     assert page.has_content?(@category.title), "missing name of category: #{@category.title}"
  #   end
  # 
  #   within('#my-lessons .topic-list ul li') do
  #     assert page.has_content?(lesson_name), "missing name of new lesson: #{lesson_name}"
  #   end    
  # end
  
  private
  def create_user_and_sign_in
    user = Factory.create(:user)
    
    visit(root_path)
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button('Sign in')    
  end
  
  def assert_current_path(path)
    assert_equal path, current_path
  end
  
  def assert_lesson_displayed(lesson_name)
    within('#my-lessons li') do
      assert page.has_content?(lesson_name), "missing name of new lesson: #{lesson_name}"
    end    
  end
       
end
