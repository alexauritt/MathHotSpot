require_relative "../dev/math_problem_collection_spec"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

require 'test/unit'
require 'mocha'

class MathProblemCollectionSpecTest < Test::Unit::TestCase
  def setup
    @spec = {
      :problem_type_title => "Simple Equations: One Variable, Addition"
      :problem_level_number => 1
      :question_template => '\[x + @left = @right\]'
      :answer_template => '\[x = @solution\]'
      :values => [{:left => 0, :right => 1, :solution => 23}, {:left => 0, :right => 1, :solution => 23}]
    }
  end
end