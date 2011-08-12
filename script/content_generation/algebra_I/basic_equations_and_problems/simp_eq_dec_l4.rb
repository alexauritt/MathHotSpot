require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

values_list = []

100.times do
  # for types 3 - 8
  dec = Random.digit_integer(20)
  diff = Random.digit_integer(20)
  sum = Random.round_tens(dec + diff)
  
  # for types 1 and 2
  int_diff = rand(20)
  total = Random.round_tens(dec + int_diff)
    
  values_list << {variable: Random.variable, decimal: dec, difference: diff, sum: sum, total: total, int_diff: int_diff}
end

args = {
    :problem_type_title => "Simple Equations with Decimals, No Coefficients, Addition and Subtraction",
    :problem_level_number => 4,
    :question_template => ['\[@decimal = @variable - @int_diff\]', '\[@variable - @int_diff = @decimal\]', '\[@decimal = @variable - @difference\]', '\[@variable - @difference = @decimal\]', '\[@variable + @difference = @sum\]', '\[@difference + @variable = @sum\]', '\[@sum = @variable + @difference\]', '\[@sum = @difference + @variable\]'],
    :answer_template => ['\[@total = @variable\]', '\[@variable = @total\]', '\[@sum = @variable\]', '\[@variable = @sum\]', '\[@variable = @decimal\]', '\[@variable = @decimal\]', '\[@decimal = @variable\]', '\[@decimal = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.file_name = "simp_eq_dec_l4"
builder.build!

