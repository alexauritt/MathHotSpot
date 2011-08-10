require 'test/unit'
require 'mocha'
require_relative '../../../lib/content_generation/math_yaml_builder'
require_relative '../../../lib/content_generation/problem_existence_checker'

class MathYamlBuilderTest < Test::Unit::TestCase
  @file_output_location = "/my_file_will_go_here/"
  def setup
    @default_builder_params = {
      :problem_type_title => "a problem of some kind",
      :problem_level_number => 1,
      :values_list => [{value: 100, answer: 50},{value: 200, answer: 75}],
      :question_template => "some question goes here with a @value",
      :answer_template => "some answer goes here with an @answer"
    }
    @math_yaml_builder = MathYamlBuilder.new(@default_builder_params)
  end
  
  def test_file_name
    assert_equal "a_problem_of_some_kind_level_1", @math_yaml_builder.send(:file_name)
  end
  
  def test_file_name_with_punctuation_and_caps
    title = 'a TRULY!    FanTASTIC problem brought to you, by... MENNEN!!!!!!!!'
    mennen_builder = MathYamlBuilder.new(@default_builder_params.update(problem_type_title: title))
    assert_equal "a_truly_fantastic_problem_brought_to_you_by_mennen_level_1", mennen_builder.send(:file_name)    
  end
  
  def test_build!
    title = "a really, REALLY wonderful problem"
    level_number = 43
    
    builder = MathYamlBuilder.new(@default_builder_params.update({problem_type_title: title, problem_level_number: level_number}))
    
    stub_file_output_location!
    assert_delegation_to_problem_existence_checker! builder    
    
    file = mock_file("a_really_really_wonderful_problem_level_43.yml")
    problem_1_yaml = "-\n  problem_level_id: 200\n  question_markup: some question goes here with a 100\n  answer_markup: some answer goes here with an 50\n\n"
    problem_2_yaml = "-\n  problem_level_id: 200\n  question_markup: some question goes here with a 200\n  answer_markup: some answer goes here with an 75\n\n"
    file.expects(:puts).with(problem_1_yaml)
    file.expects(:puts).with(problem_2_yaml)

    builder.build!
  end
    
  private

  def mock_file(file_name)
    file = mock
    File.expects(:open).with("#{@file_output_location}/tmp/content_generation/#{file_name}", 'w').returns(file)
    file.expects(:close)
    file
  end
  
  def assert_delegation_to_problem_existence_checker!(math_yaml_builder)
    mock_checker = mock
    problem_type_id = 100
    problem_type = ProblemType.new(:title => math_yaml_builder.problem_type_title)
    problem_level_id = 200
    problem_level = ProblemLevel.new(:problem_type_id => 100, :level_number => math_yaml_builder.problem_level_number)
    problem_type.expects(:id).returns(problem_type_id)
    problem_level.expects(:id).returns(problem_level_id)
    mock_checker.expects(:level_number).returns(math_yaml_builder.problem_level_number)
    mock_checker.expects(:problem_type_and_level_in_db?).returns(true)
    mock_checker.expects(:problem_type).returns(problem_type)
    ProblemLevel.expects(:find_by_problem_type_id_and_level_number).with(problem_type_id, math_yaml_builder.problem_level_number).returns(problem_level)
    MathMaker::ProblemExistenceChecker.expects(:new).with(math_yaml_builder.problem_type_title, math_yaml_builder.problem_level_number).returns(mock_checker)
  end
  
  def stub_math_problem_yaml_text_creator!
    MathProblemYamlTextCreator.stubs(:problem_yaml_text).with(any_parameters).returns('something')    
  end
  
  def stub_file_output_location!
    Rails.stubs(:root).returns(@file_output_location)
  end
end