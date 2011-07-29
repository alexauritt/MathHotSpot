require_relative "../dev/math_problem_yaml_generator"
require_relative "../dev/math_problem_collection_spec"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'test/unit'
require 'mocha'
class MathProblemYAMLGeneratorTest < Test::Unit::TestCase

  def setup
    @spec = {
      :problem_type_title => "Simple Equations: One Variable, Addition"
      :problem_level_number => 1
      :question_template => '\[x + @left = @right\]'
      :answer_template => '\[x = @solution\]'
      :values => [{:left => 0, :right => 1, :solution => 23}, {:left => 0, :right => 1, :solution => 23}]
    }
    
    @mock_spec = mock
    @mock_spec.stubs(:instance_of?).with(MathProblemCollectionSpec).returns(true)
    @mock_spec.stubs(:valid?).returns(true)
  end

  def test_generate_yaml_returns_nil_if_parameter_is_a_string
    assert_nil MathProblemYAMLGenerator.yaml_text("this is not a collection spec")
  end
  
  def test_generate_yaml_returns_nil_for_invalid_collection_spec
    @mock_spec.expects(:valid?).returns(false)
    assert_nil MathProblemYAMLGenerator.yaml_text(@mock_spec)
  end
  
  def test_generate_yaml_searches_for_problem_type_specified_in_spec
    title = " a title"
    @mock_spec.stubs(:problem_type_title).returns(title)
    ProblemType.expects(:find_by_title).with(title)
    
    MathProblemYAMLGenerator.yaml_text(@mock_spec)
  end
  
  def test_generator_accepts_spec
  end
end