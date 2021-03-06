ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../../config/environment', __FILE__)
require 'rails/test_help'

require_relative '../../../lib/content_generation/content_generation_helper.rb'


class ProblemExistenceCheckerTest < Test::Unit::TestCase
  
  def setup
    @problem_type_title = 'best problem type ever'
    @level_number = 666
    @checker = MathMaker::ProblemExistenceChecker.new(@problem_type_title, @level_number)
    
    @mock_problem_type = ProblemType.new
    @mock_problem_level = @mock_problem_type.problem_levels.build
  end
    
  def test_checker_indicates_if_problem_type_not_in_db
    expects_error(MathMaker::ProblemTypeNotFoundError::MESSAGE)
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(nil)
    assert_equal false, @checker.problem_type_and_level_in_db?
  end
  
  def test_checker_indicates_if_level_missing_but_problem_type_is_in_db
    fake_id = 876876
    type = mock
    type.stubs(:id).returns(fake_id)
    type.stubs(:nil?).returns(false)
    expects_error(MathMaker::ProblemLevelNotFoundError::MESSAGE)
    ProblemLevel.stubs(:find_by_problem_type_id_and_level_number).with(fake_id, @level_number).returns(nil)
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(type)

    assert_equal false, @checker.problem_type_and_level_in_db?
  end
  
  def test_checker_identifies_admin_owned_problem
    expects_problem_type_query!
    mock_admin = stub(:id => 1)
    @mock_problem_type.expects(:owner).returns(mock_admin)
    assert @checker.is_admin_owner?, "ProblemExistenceCheckerFailed to recognize that ProblemType belongs to admin."
  end
  
  def test_checker_identifies_non_admin_owned_problem
    expects_problem_type_query!
    mock_non_admin = stub(:id => 2)
    @mock_problem_type.expects(:owner).returns(mock_non_admin)
    assert !@checker.is_admin_owner?, "ProblemExistenceCheckerFailed to recognize that ProblemType does not belong to admin."
  end
  
  private
  def expects_problem_type_query!
    ProblemType.expects(:find_by_title).with(@problem_type_title).returns(@mock_problem_type)
  end
  
  def expects_error(message)
    $stdout.expects(:puts).with(message)    
  end
end