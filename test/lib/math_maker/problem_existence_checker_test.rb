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
  
  def test_checker_indicates_if_problem_type_not_in_db
    expects_unable_to_find_problem_type_in_db_message!
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(nil)
    assert_equal false, @checker.problem_type_and_level_in_db?
  end
  
  def test_checker_indicates_if_level_missing_but_problem_type_is_in_db
    fake_id = 876876
    type = stubs(:id => fake_id, :nil? => false)
    expects_unable_to_find_problem_type_in_db_message!
    ProblemLevel.stubs(:find_by_problem_type_id_and_level_number).with(fake_id, @level_number).returns(nil)
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(type)

    assert_equal false, @checker.problem_type_and_level_in_db?
  end  
  
  private
  def expects_unable_to_find_problem_type_in_db_message!
    $stdout.expects(:puts).with("Unable to find Problem Type / Level specified")    
  end
end