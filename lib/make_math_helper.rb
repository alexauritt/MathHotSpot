require "content_generation/problem_existence_checker"
require "content_generation/math_problem_yaml_text_creator"
require "content_generation/math_yaml_builder"

class Shuffler < Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end