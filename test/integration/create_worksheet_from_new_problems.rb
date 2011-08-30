require 'test_helper'
require 'integration_test_helper'

class CreateWorksheetFromNewProblemsTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers

  setup do
    DatabaseCleaner.start
    @user = Factory(:user)
    sign_in_as @user
  end

  teardown do
    DatabaseCleaner.clean
  end
  
  test "create new problems, generate worksheet and swap problems" do
    questions = [
      'How many raisins can you fit up your nose?',
      'How many jellybeans can you fit in your mouth?',
      'How many bowling pins can you juggle?',
      'How many pieces of gum have you swallowed in your life?']
    answers = ['3 raisans', '4 jellybeans', '20 bowling pins', '5 pieces of gum']
    
    visit root_path
    click_link "Create a New Problem Type"
    
    assert_current_path new_problem_type_path
    
    fill_in 'Title', :with => "Vaguely Scatological Word Problems"
    fill_in 'Level number', :with => '1'
    fill_in 'Question markup', :with => questions[0]
    fill_in 'Answer markup', :with => answers[0]
    
    # create type/first level/ first problem
    click_button 'Create Problem type'
    assert_current_path "/problem_types/vaguely-scatological-word-problems"
    click_link "Level: 1"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/problem_levels/1"
  
    # create second problem
    click_link "Create Similar Problem"  
    fill_in 'Question markup', :with => questions[1]
    fill_in 'Answer markup', :with => answers[1]
    click_button 'Create Math problem'
    
    # create second level/first problem
    click_link "Back to Level"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/problem_levels/1"
    click_link "Back to Problem Type"
    assert_current_path "/problem_types/vaguely-scatological-word-problems"
    click_link "Edit Problem Type / Add or Delete Tags"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/edit"
    click_link "Add New Level"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/problem_levels/new"
    
    fill_in 'Level number', :with => '2'
    fill_in 'Question markup', :with => questions[2]
    fill_in 'Answer markup', :with => answers[2]
    click_button "Create Problem level"
    
    assert_current_path "/problem_types/vaguely-scatological-word-problems"
    
    click_link "Level: 2"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/problem_levels/2"    

    click_link "Add New Problem to this Level"
    assert_current_path "/problem_types/vaguely-scatological-word-problems/problem_levels/2/math_problems/new"

    fill_in 'Question markup', :with => questions[3]
    fill_in 'Answer markup', :with => answers[3]
    click_button 'Create Math problem'
    
    visit "/problem_types/vaguely-scatological-word-problems"
    click_link "Create New Worksheet with this Problem Type"
    
    assert_current_path "/problem_types/vaguely-scatological-word-problems/worksheet_builder"
  end
  
  private
  def assert_problem_changes_on_update!(worksheet, problem_number)
    compare_problem_before_and_after_update!(worksheet, problem_number, false)
  end

  def assert_problem_does_not_change_on_update!(worksheet, problem_number)
    compare_problem_before_and_after_update!(worksheet, problem_number, true)
  end

  def compare_problem_before_and_after_update!(worksheet, problem_number, should_be_equal)
    # Rails.logger.info "here comapring"
    next_num = problem_number - 1
    initial_node = page.find("#problem_#{next_num} .question")
    # Rails.logger.info "here is #{initial_node}"
    within("#problem_#{next_num}") do
      click_button('replace')
    end
    after_node = page.find("#problem_#{next_num} .question")

    if (should_be_equal)
      assert_equal initial_node, after_node, "Problem #{problem_number} change after replace call but should have remained unchanged."
    else
      assert_not_equal initial_node, after_node, "Problem #{problem_number} did not change after replace call."
    end
  end
  
end
