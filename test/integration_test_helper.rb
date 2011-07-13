require "test_helper"
require "capybara/rails"
require 'database_cleaner'
 
module ActionController
  class IntegrationTest
    include Capybara::DSL
    self.use_transactional_fixtures = false
  end
end