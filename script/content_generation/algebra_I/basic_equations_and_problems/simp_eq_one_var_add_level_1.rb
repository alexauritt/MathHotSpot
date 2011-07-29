# # require "math_problem_yaml_text_creator"
# list = $LOAD_PATH.map {|cur| cur}
# list.each do |l|
#   puts "one LP is #{l}"
# end

$LOAD_PATH << "#{RAILS_ROOT}/lib/content_generation"
require "math_problem_yaml_text_creator"

class Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end

problem_type_title = "Simple Equations: One Variable, Addition"
problem_level_number = 1
question_template = '\[x + @left = @right\]'
answer_template = '\[x = @solution\]'

#produce values
values_list = []
10.times do |left_val|
  Array(left_val .. 9).each do |right_val|
    values_list << {left: left_val, right: right_val, solution: right_val - left_val }
  end
end

#shuffle values
values_list.shuffle!

#ensure specified problem type / level is in db

#create one math problem for each listed value
begin
  type = ProblemType.find_by_title("Simple Equations: One Variable, Addition")
  raise if type.nil?
  level = ProblemLevel.find_by_problem_type_id_and_level_number(type.id, 1)
  raise if level.nil?
rescue
  puts "Unable to find Problem Type / Level specified"
end

# open target yml file
if level
  dir = File.dirname(__FILE__)
  target_filename = dir + "/" + File.basename(__FILE__, '.rb') + ".yml"
  
  problem_info = {
    :problem_level_id => level.id, 
    :markup_templates => {
      :question => '\[x + @left = @right\]',
      :answer => '\[x = @solution\]'
    }
  }

  begin
    target = File.open(target_filename, 'w')
    values_list.each do |value_group|
      data = problem_info.merge({:values => value_group})
      yml_data = MathProblemYamlTextCreator.problem_yaml_text(data)
      target.puts yml_data
    end
    
    target.close
  rescue
    puts "unable to write yml file full of math problems"
  end
end



