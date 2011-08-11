require "content_generation/shuffleable"
require "content_generation/problem_existence_checker"
require "content_generation/math_problem_yaml_text_creator"
require "content_generation/math_yaml_builder"

class Random
  def self.round_tens(val)
    val % 1 == 0 ? val.to_i : val.round(1) 
  end
  
  def self.digit_decimal
    round_tens(rand(100) / 10.0)
  end
  
  def self.digit_integer(max = 10)
    round_tens(rand(max * 10) / 10.0)
  end
  
  def self.variable
    val = rand(10)
    case val
    when 0..3
      'x'
    when 4..5
      'y'
    when 6
      'm'
    when 7
      'k'
    when 8
      'w'
    when 9
      'a'
    end
  end    
end