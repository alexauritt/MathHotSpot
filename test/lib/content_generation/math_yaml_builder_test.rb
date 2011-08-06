require 'test/unit'
require 'mocha'
require_relative '../../../lib/content_generation/math_yaml_builder'

class MathYamlBuilderTest < Test::Unit::TestCase
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
end