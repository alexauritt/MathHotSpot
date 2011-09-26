require 'test_helper'
require 'integration_test_helper'

class EditWorksheetTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers

  setup do
    DatabaseCleaner.start
    @user = Factory(:user)
    sign_in_as @user
    
    @problem_type = Factory.create(:problem_type, :title => "Exponents of Really Big Numbers", :owner => @user)
    @problem_level_1 = Factory.create(:problem_level, :problem_type => @problem_type, :level_number => 1)
    @problem_level_2 = Factory.create(:problem_level, :problem_type => @problem_type, :level_number => 2)
    @replaceable_1 = Factory.create(:math_problem, :owner => @user, :problem_level => @problem_level_1)
    @replaceable_2 = Factory.create(:math_problem, :owner => @user, :problem_level => @problem_level_1)
    @non_replaceable = Factory.create(:math_problem, :owner => @user, :problem_level => @problem_level_2)
    

    @worksheet = Factory.create(:worksheet, :owner => @user)
    @worksheet.worksheet_problems.create(:problem_number => 1, :math_problem => @replaceable_1)
    @worksheet.worksheet_problems.create(:problem_number => 2, :math_problem => @non_replaceable)    

    @worksheet_title = @worksheet.title
    @replaceable_1_question_content = @replaceable_1.question_markup
    @replaceable_2_question_content = @replaceable_2.question_markup
    @non_replaceable_question_content = @non_replaceable.question_markup
  end

  test "problems appear as expected on problem level display pages" do
    visit problem_type_problem_level_path(@problem_type, @problem_level_1)

    assert page.has_no_content? @non_replaceable_question_content
    assert page.has_content? @replaceable_1_question_content
    assert page.has_content? @replaceable_2_question_content
    
    visit problem_type_problem_level_path(@problem_type, @problem_level_2)

    assert page.has_content? @non_replaceable_question_content
    assert page.has_no_content? @replaceable_1_question_content
    assert page.has_no_content? @replaceable_2_question_content
  end
  
  test "replace problem with available replacement" do
    visit dashboard_path
    click_link @worksheet_title
    
    click_link "Edit Worksheet"
    
    assert_problem_replaceable '#problem_1'
    assert_problem_not_replaceable '#problem_2'
    
    within('#problem_1') do
      assert find('.question').has_content?(@replaceable_1_question_content)
      assert find('.question').has_no_content?(@replaceable_2_question_content)

      click_button('replace')          
    end
    
    assert_current_path edit_worksheet_path(@worksheet)
    
    assert_problem_replaceable '#problem_1'
    
    within('#problem_1') do
      assert find('.question').has_no_content? @replaceable_1_question_content
      assert find('.question').has_content? @replaceable_2_question_content
    end    
  end
  
  test "add similar problem to worksheet" do
    visit edit_worksheet_path @worksheet
    
    assert page.has_selector?('#problem_1')
    assert page.has_no_selector?('#problem_3')
    
    assert_problem_replaceable '#problem_1'

    within '#problem_1' do
      click_button 'add similar'
    end
    
    assert_current_path edit_worksheet_path @worksheet
    
    within '#problem_3' do
      assert find('.question').has_content? @replaceable_2_question_content
    end
  end
    
  test "create similar problem" do
    visit edit_worksheet_path @worksheet
    
    assert_problem_replaceable '#problem_1'
    assert_problem_not_replaceable '#problem_2'
    
    within('#problem_2') do
      question = find '.question'
      assert question.has_content? @non_replaceable_question_content

      click_button 'create similar'
    end
    
    assert_current_path worksheet_problem_clone_path(@worksheet, 2)
    
    new_question = 'this will be the question for the new third question'
    new_answer = 'This is the answer for question 3'
    
    fill_in 'Question markup', :with => new_question
    fill_in 'Answer markup', :with => new_answer
    
    click_button 'Create New Problem for Worksheet'
    
    assert_current_path edit_worksheet_path @worksheet
    
    within('#problem_3') do
      assert find('.question').has_content? new_question
    end
    
    visit problem_type_problem_level_path(@problem_type, @problem_level_2)
    
    assert page.has_content? new_question
  end
    
  teardown do
    DatabaseCleaner.clean
  end
  
  private
  def assert_problem_replaceable(id)
    assert_problem_replaceability(id)
  end
  
  def assert_problem_not_replaceable(id)
    assert_problem_replaceability id, false
  end
  
  def assert_problem_replaceability(id, status = true)
    links = find("#{id} .problem-links")
    assert_equal status, links.has_no_button?('create similar')
    assert_equal status, links.has_button?('replace')
    assert_equal status, links.has_button?('add similar')
  end
end