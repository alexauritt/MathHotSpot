require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

#produce values

values_list = []
(3..20).each do |addend_val|
  (8..22).each do |solution|
    values_list << {variable: Random.variable, addend: addend_val, sum: (addend_val + solution), solution: solution }
  end
end

args = {
    :problem_type_title => "Simple Equations with Positive Integers, No Coefficients, Addition and Subtraction",
    :problem_level_number => 3,
    :question_template => ['\[@variable + @addend = @sum\]', '\[@addend + @variable = @sum\]', '\[@sum = @variable + @addend\]', '\[@sum = @addend + @variable\]'],
    :answer_template => ['\[@variable = @solution\]', '\[@variable = @solution\]', '\[@solution = @variable\]', '\[@solution = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.build!

