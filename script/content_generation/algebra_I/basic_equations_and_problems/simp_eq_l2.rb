require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

#produce values

values_list = []
10.times do |subtrahend|
  Array(subtrahend .. 9).each do |solution|
    values_list << {variable: Random.variable, subtrahend: subtrahend, difference: solution - subtrahend, solution: solution }
  end
end

args = {
    :problem_type_title => "Simple Equations with Positive Integers, No Coefficients, Addition and Subtraction",
    :problem_level_number => 2,
    :question_template => ['\[@variable - @subtrahend = @difference\]', '\[@difference = @variable - @subtrahend\]'],
    :answer_template => ['\[@variable = @solution\]', '\[@solution = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.file_name = "simp_eq_l2"
builder.build!

