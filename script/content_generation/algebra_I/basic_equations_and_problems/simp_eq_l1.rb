require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

#produce values

values_list = []
10.times do |addend_val|
  Array(addend_val .. 9).each do |sum_val|
    values_list << {variable: Random.variable, addend: addend_val, sum: sum_val, solution: sum_val - addend_val }
  end
end

args = {
    :problem_type_title => "Simple Equations with Positive Integers, No Coefficients, Addition and Subtraction",
    :problem_level_number => 1,
    :question_template => ['\[@variable + @addend = @sum\]', '\[@addend + @variable = @sum\]', '\[@sum = @variable + @addend\]', '\[@sum = @addend + @variable\]'],
    :answer_template => ['\[@variable = @solution\]', '\[@variable = @solution\]', '\[@solution = @variable\]', '\[@solution = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.build!

