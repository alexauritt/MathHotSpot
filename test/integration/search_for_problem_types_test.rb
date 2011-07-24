require 'test_helper'
require 'integration_test_helper'

class SearchForProblemTypesTest < ActionDispatch::IntegrationTest
  include ActionController::IntegrationTest::Authenticatable
  include ActionController::IntegrationTest::IntegrationTestHelpers
  include ActionController::IntegrationTest::ProblemTypeSearchy

  setup do
    DatabaseCleaner.start
    @user = Factory(:user)
    @lesson = @user.lessons.first
    sign_in_as @user
  end

  test "search for problem types for lesson" do
    problem_type = Factory.create(:problem_type, :title => "Exponents of Imaginary Numbers", :owner => @user)
    different = Factory.create(:problem_type, :title => "goo goo ga ga", :owner => @user)
    visit new_problem_types_search_path(@lesson)
    
    fill_in 'search_query', :with => "exponenTS of iMaginary"
    click_button 'Search'

    assert_current_path problem_types_search_path
    assert_problem_type_displayed_in_search_results problem_type
  end

end
