require "#{Rails.root.to_s}/lib/make_math_helper"

#produce values
values_list = Shuffler.new
10.times do |left_val|
  Array(left_val .. 9).each do |right_val|
    values_list << {left: left_val, right: right_val, solution: right_val - left_val }
  end
end

#shuffle values
values_list.shuffle!
args = {
    :problem_type_title => "Simple Equations: One Variable, Addition",
    :problem_level_number => 1,
    :question_template => '\[x + @left = @right\]',
    :answer_template => '\[x = @solution\]',
    :values_list => values_list
}
builder = MathYamlBuilder.new(args)
builder.build!

