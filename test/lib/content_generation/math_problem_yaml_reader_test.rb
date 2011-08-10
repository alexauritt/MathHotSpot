require 'test/unit'
require 'mocha'
require_relative '../../../lib/content_generation/math_problem_yaml_reader'

class MathProblemYamlReaderTest < Test::Unit::TestCase
  def setup
    @yaml_reader = MathProblemYamlReader.new
  end
  
  def test_yaml_reader_returns_false_if_file_does_not_load
    bad_file = "bad_file.yaml"
    yaml_reader = MathProblemYamlReader.new
    assert_equal false, yaml_reader.load(bad_file)
  end
  
  def test_yaml_reader_returns_true_if_file_exists_in_tmp
    good_file = "good_file"
    file_path = "tmp/content_generation/#{good_file}.yml"
    File.expects(:exists?).with(file_path).returns(true)
    mock_file = mock
    File.expects(:open).with(file_path).returns(mock_file)

    assert_equal true, @yaml_reader.load(good_file)
  end
  
  def test_yaml_reader_returns_false_if_problems_from_multiple_levels_are_specified
    file_with_multiple_levels = "some address"
    assert_equal false, @yaml_reader.load(file_with_multiple_levels)
  end
  
  # def test_yaml_reader_returns_true_if_problems_specified_are_all_from_same_level
  # 
  # end
  # 
  # def test_create_stores_notice_if_any_problem_fails_to_be_created
  # 
  # end
  
end
