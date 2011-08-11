require "#{Rails.root.to_s}/lib/content_generation/content_generation_helper"

values_list = []

100.times do
  # for types 3 - 8
  dec = Random.digit_decimal
  roundup = Random.round_tens(dec.ceil - dec)
  diff = Random.round_tens(rand(5) + roundup)
  sum = (dec + diff).to_i
  
  # for types 1 and 2
  int_diff = rand(20)
  total = Random.round_tens(dec + int_diff)
    
  values_list << {variable: Random.variable, decimal: dec, difference: diff, sum: sum, total: total, int_diff: int_diff}
end

args = {
    :problem_type_title => "Simple Equations with Real Numbers, No Coefficients, Addition and Subtraction",
    :problem_level_number => 1,
    :question_template => ['\[@decimal = @variable - @int_diff\]', '\[@variable - @int_diff = @decimal\]', '\[@decimal = @variable - @difference\]', '\[@variable - @difference = @decimal\]', '\[@variable + @difference = @sum\]', '\[@difference + @variable = @sum\]', '\[@sum = @variable + @difference\]', '\[@sum = @difference + @variable\]'],
    :answer_template => ['\[@total = @variable\]', '\[@variable = @total\]', '\[@sum = @variable\]', '\[@variable = @sum\]', '\[@variable = @decimal\]', '\[@variable = @decimal\]', '\[@decimal = @variable\]', '\[@decimal = @variable\]'],
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.file_name = "simp_eq_real_l1"
builder.build!

