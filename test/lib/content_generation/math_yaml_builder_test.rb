require 'test/unit'
require 'mocha'
require_relative '../../../lib/content_generation/math_yaml_builder'
require_relative '../../../lib/content_generation/problem_existence_checker'

class MathYamlBuilderTest < Test::Unit::TestCase
  @file_output_location = "/my_file_will_go_here/"
  def setup
    @math_yaml_builder = MathYamlBuilder.new({
      :problem_type_title => "a really, REALLY wonderful problem",
      :problem_level_number => 43,
      :values_list => [{value: 100, answer: 50},{value: 200, answer: 75}],
      :question_markup => "some question goes here with a @value",
      :answer_markup => "some answer goes here with an @answer"
    })
  end
  
  def test_file_name
    assert_equal "a_really_really_wonderful_problem_level_43", @math_yaml_builder.send(:file_name)
  end
  
  def test_build!
    stub_problem_existence_checker!
    mock_file = mock
    mock_file.expects(:puts).with("something").at_least_once
    File.expects(:open).with("#{@file_output_location}/tmp/content_generation/a_really_really_wonderful_problem_level_43.yml", 'w').returns(mock_file)
    mock_file.expects(:close)
    @math_yaml_builder.build!
  end
  
  private
  def stub_problem_existence_checker!
    mock_checker = mock
    mock_problem_type = stub(:id => 432)
    mock_problem_level = stub(:id => 234)
    mock_checker.stubs(:level_number).returns(2)
    mock_checker.stubs(:problem_type_and_level_in_db?).returns(true)
    mock_checker.stubs(:problem_type).returns(mock_problem_type)
    Rails.stubs(:root).returns(@file_output_location)
    ProblemLevel.stubs(:find_by_problem_type_id_and_level_number).returns(mock_problem_level)
    MathMaker::ProblemExistenceChecker.stubs(:new).returns(mock_checker)
    MathProblemYamlTextCreator.stubs(:problem_yaml_text).with(any_parameters).returns('something')
  end
end