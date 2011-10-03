require 'test_helper'
require 'integration_test_helper'

class CreateNewEmptyWorksheetTest < ActionDispatch::IntegrationTest
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
end