require 'test_helper'
require 'integration_test_helper'

class CreateWorksheetTest < ActionDispatch::IntegrationTest
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

  test "create new empty worksheet" do
    title = "A new worksheet"

    visit dashboard_path
    assert page.has_no_content? title
    
    within('#my-worksheets') do
      click_link "Create a New Worksheet"
    end
    
    assert_current_path new_worksheet_path
    
    fill_in "Title", :with => title
    
    click_button "Create Worksheet"
    
    visit dashboard_path
    assert page.has_content? title
  end
  
  test "add existing problem to new worksheet" do
    level = Factory.create(:problem_level)
    math_problems = FactoryGirl.create_list(:math_problem, 2, :problem_level => level)
    worksheet = Factory.create(:worksheet)

    visit worksheet_path(worksheet)
    visit problem_type_problem_level_url(level.problem_type.permalink, level.level_number)
    assert page.has_content? worksheet.title
    
    #ensure none of the new math problems are displayed as part of current worksheet
    within '.current-asset-wrapper' do
      worksheet_display = find('#current-asset-short')
      math_problems.each do |mp|
        assert worksheet_display.has_no_content?(mp.question_markup)
      end
    end
    
    problem_display = page.all('.math-display')

    within problem_display[0] do
      click_button "Add Problem to Worksheet"
    end
    
    visit problem_type_problem_level_url(level.problem_type.permalink, level.level_number)

    within '.current-asset-wrapper' do
      worksheet_display = find('#current-asset-short')
      assert worksheet_display.has_content?(math_problems.first.question_markup)
      assert worksheet_display.has_no_content?(math_problems[1].question_markup)
    end
    
    problem_display = page.all('#main-problem-levels .math-display')

    assert_equal 2, problem_display.size
    assert problem_display[0].find('.math-problem-links').has_no_button?('Add Problem to Worksheet')    
    assert problem_display[1].find('.math-problem-links').has_button?('Add Problem to Worksheet')      
  end
  
end