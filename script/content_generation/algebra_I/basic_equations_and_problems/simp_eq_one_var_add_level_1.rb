require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

#produce values

def random_variable
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

values_list = []
10.times do |addend_val|
  Array(addend_val .. 9).each do |sum_val|
    values_list << {variable: random_variable, addend: addend_val, sum: sum_val, solution: sum_val - addend_val }
  end
end

args = {
    :problem_type_title => "Simple Equations: One Variable, Addition",
    :problem_level_number => 1,
    :question_template => ['\[@variable + @addend = @sum\]', '\[@addend + @variable = @sum\]', '\[@sum = @variable + @addend\]', '\[@sum = @addend + @variable\]'],
    :answer_template => ['\[@variable = @solution\]', '\[@variable = @solution\]', '\[@solution = @variable\]', '\[@solution = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.build!

