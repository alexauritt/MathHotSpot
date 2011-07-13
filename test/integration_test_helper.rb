require "test_helper"
require "capybara/rails"
require 'database_cleaner'
 
module ActionController
  class IntegrationTest
    include Capybara::DSL
    self.use_transactional_fixtures = false
    
    module Authenticatable
      def sign_in_as(user)
        visit(root_path)
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
        click_button('Sign in')        
      end
    end
    
    module IntegrationTestHelpers
      def assert_current_path(path)
        assert_equal path, current_path
      end
    end
    
    module Lessony
      def assert_lesson_displayed(lesson_name)
        within("#my-lessons ul") do
          assert page.has_content?(lesson_name), "missing name of new lesson: #{lesson_name}"
        end    
      end

      def assert_lesson_not_displayed(lesson_name)
        within("#my-lessons ul") do
          assert !page.has_content?(lesson_name), "missing name of new lesson: #{lesson_name}"
        end        
      end      
    end
  end
end