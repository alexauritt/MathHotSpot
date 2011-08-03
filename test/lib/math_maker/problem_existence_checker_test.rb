ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../../config/environment', __FILE__)
require 'rails/test_help'

require_relative '../../../lib/make_math_helper.rb'


class ProblemExistenceCheckerTest < Test::Unit::TestCase
  def setup
    @problem_type_title = 'best problem type ever'
    @level_number = 666
    @checker = MathMaker::ProblemExistenceChecker.new(@problem_type_title, @level_number)
  end
  def test_01
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(nil)
    assert_equal false, @checker.problem_type_and_level_in_db?
  end
end