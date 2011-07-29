require 'test/unit'
require_relative '../../../lib/content_generation/math_problem_yaml_text_creator'

class MathProblemYamlTextCreatorTest < Test::Unit::TestCase
  def test_somthing
    assert true
  end
  
  def test_no_no
    assert_equal 50, MathProblemYamlTextCreator.doit
  end
end