require 'test_helper'
require 'integration_test_helper'

class ReplaceWorksheetProblemErrorMessagesTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers

  setup do
    DatabaseCleaner.start
    @user = Factory(:user)
    @worksheet = worksheets(:monomial_worksheet_01)
    
    sign_in_as @user
  end

  teardown do
    DatabaseCleaner.clean
  end
  
  test "error message appears if user requests replacement of unique problem" do
    unique_problem = worksheet_problems(:monomial_worksheet_unique_problem)
    assert_equal unique_problem, @worksheet.problem(6), "Test assumes a certain fixture arrangment"

    visit worksheet_path(@worksheet)    
    assert page.has_no_content? MathHotSpotErrors::Message::UNIQUE
    
    click_link "Edit Worksheet"
    within('#problem_6') do
      click_button "replace"
    end
    
    assert page.has_content? MathHotSpotErrors::Message::UNIQUE
  end 

  test "error message appears if user request replacement of problem when there are no remaining problems of given type" do
    second_problem_of_two_on_worksheet = worksheet_problems(:monomial_worksheet_prob_05)
    assert_equal second_problem_of_two_on_worksheet, @worksheet.problem(5), "Test assumes a certain fixture arrangment"

    visit worksheet_path(@worksheet)    
    assert page.has_no_content? MathHotSpotErrors::Message::NONE_REMAINING
    
    click_link "Edit Worksheet"
    within('#problem_5') do
      click_button "replace"
    end    
    assert page.has_content? MathHotSpotErrors::Message::NONE_REMAINING
  end

end