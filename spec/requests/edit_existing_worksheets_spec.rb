require 'spec_helper'
include Capybara::DSL
include RightRabbit::TestHelpers::Authenticatable

describe "View Worksheet" do
  before(:all) do
    DatabaseCleaner.start
    @user = Factory(:user)
    sign_in_as @user
    # 
    # @problem_type = Factory.create(:problem_type, :title => "Exponents of Really Big Numbers", :owner => @user)
    # @problem_level_1 = Factory.create(:problem_level, :problem_type => @problem_type, :level_number => 1)
    # @problem_level_2 = Factory.create(:problem_level, :problem_type => @problem_type, :level_number => 2)
    # @replaceable_1 = Factory.create(:math_problem, :owner_id => @user.id, :problem_level => @problem_level_1)
    # @replaceable_2 = Factory.create(:math_problem, :owner_id => @user.id, :problem_level => @problem_level_1)
    # @non_replaceable = Factory.create(:math_problem, :owner_id => @user.id, :problem_level => @problem_level_2)
    # 
    @worksheet = Factory.create(:worksheet, :owner => @user)
    # Factory.create(:worksheet_problem, :worksheet => @worksheet, :problem_number => 1, :math_problem => @replaceable_1)
    # Factory.create(:worksheet_problem, :worksheet => @worksheet, :problem_number => 2, :math_problem => @non_replaceable)
    # 
    # @worksheet_title = @worksheet.title
    # @replaceable_1_question_content = @replaceable_1.question_markup
    # @replaceable_2_question_content = @replaceable_2.question_markup
    # @non_replaceable_question_content = @non_replaceable.question_markup
    # 
    # @new_problem_for_worksheet_label = "Create New Problem for Worksheet"
  end
  
  
  describe "GET /worksheet" do
    it "should display worksheet" do
      visit worksheet_path(@worksheet)
    end
    # it "has expected problem content" do
    #   visit problem_type_problem_level_path(@problem_type, @problem_level_1.level_number)
    # 
    #   assert page.has_no_content? @non_replaceable_question_content
    #   assert page.has_content? @replaceable_1_question_content
    #   assert page.has_content? @replaceable_2_question_content
    # 
    #   visit problem_type_problem_level_path(@problem_type, @problem_level_2)
    # 
    #   assert page.has_content? @non_replaceable_question_content
    #   assert page.has_no_content? @replaceable_1_question_content
    #   assert page.has_no_content? @replaceable_2_question_content
    # end
  end
end