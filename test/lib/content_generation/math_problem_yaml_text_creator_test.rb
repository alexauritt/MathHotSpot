require 'test/unit'
require_relative '../../../lib/content_generation/math_problem_yaml_text_creator'

class MathProblemYamlTextCreatorTest < Test::Unit::TestCase

  def setup
    @problem_info = {
      :problem_level_id => 5, 
      :markup_templates => {
        :question => "something @sub_me and also @sub_this_one_too",
        :answer => "you sohuld @replace_this and also @replace_this too"
      },
      :values => {
        :sub_me => 'should go here', :sub_this_one_too => 'something should go here too',
        :replace_this => 'get rid of this'
      }
    }
    @expected_yaml = "-\n  problem_level_id: 5\n  question_markup: something should go here and also something should go here too\n  answer_markup: you sohuld get rid of this and also get rid of this too\n\n"
  end

  def test_problem_yaml_includes_problem_level
    returned_yaml = MathProblemYamlTextCreator.problem_yaml_text(@problem_info)
    assert returned_yaml.include?("-\n  problem_level_id: 5")
  end
    
  def test_problem_yaml_includes_question_and_answer_markup_keys
    returned_yaml = MathProblemYamlTextCreator.problem_yaml_text(@problem_info)
    assert returned_yaml.include?("  question_markup:")
    assert returned_yaml.include?("  answer_markup:")
  end
  
  def test_problem_yaml_includes_question_markup_with_actual_markup
    expected_question_markup = "  question_markup: something should go here and also something should go here too\n"

    returned_yaml = MathProblemYamlTextCreator.problem_yaml_text(@problem_info)

    assert returned_yaml.include?(expected_question_markup), "missing expected question markup, instead got: #{returned_yaml}"
  end
  
  def test_problem_yaml_should_raise_if_one_key_subsumes_the_other
    info_with_bad_values = {:problem_level_id => 4, :markup_templates => {:first => "@dad and @granddad"},
      :values => {
        :dad => "bad value because granddad has 'dad' in it", 
        :granddad => "I am the subsumer!"
      }}
    assert_raise ArgumentError do
      MathProblemYamlTextCreator.problem_yaml_text(info_with_bad_values)
    end    
  end
  
  def test_problem_yaml
    assert_equal @expected_yaml, MathProblemYamlTextCreator.problem_yaml_text(@problem_info)
  end
end