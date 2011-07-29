require 'yaml'

question_template = '\[x + @left = @right\]'
answer_template = '\[x = @solution\]'

dir = File.dirname(__FILE__)
target_filename = dir + "/" + File.basename(__FILE__, '.rb') + ".yml"

objs = YAML::load(File.open(target_filename))

objs.each do |val|
  MathProblem.create(val)
  # puts "values are #{val}"
end




# 
# begin
#   type = ProblemType.find_by_title("Simple Equations: One Variable, Addition")
#   raise if type.nil?
#   level = ProblemLevel.find_by_problem_type_id_and_level_number(type.id, 1)
#   raise if level.nil?
#   puts "Level is #{level}"
# 
#   target = File.open(target_filename, 'w')
# rescue
#   puts "Unable to find problem level"
# end
# 
# values_list = []
# 
# 10.times do |left_val|
#   Array(left_val .. 9).each do |right_val|
#     values_list << {left: left_val, right: right_val, solution: right_val - left_val }
#   end
# end
# 
# values_list.shuffle!
# 
# values_list.each do |h| 
#   target << ""
#   puts "vals: #{h[:left]} - #{h[:right]} - #{h[:solution]}"
# end
# 
# target.close
# 
# 
