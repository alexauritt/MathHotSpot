require "#{Rails.root.to_s}/lib/make_math_helper"


problem_type_title = "Simple Equations: One Variable, Addition"
problem_level_number = 1
question_template = '\[x + @left = @right\]'
answer_template = '\[x = @solution\]'

#produce values
values_list = Shuffler.new
10.times do |left_val|
  Array(left_val .. 9).each do |right_val|
    values_list << {left: left_val, right: right_val, solution: right_val - left_val }
  end
end

#shuffle values
values_list.shuffle!

# open target yml file
checker = MathMaker::ProblemExistenceChecker.new(problem_type_title, problem_level_number)
if checker.problem_type_and_level_in_db?

  dir = File.dirname(__FILE__)
  target_filename = Rails.root.to_s + "/tmp/content_generation/" + File.basename(__FILE__, '.rb') + ".yml"

  type = checker.problem_type
  level = ProblemLevel.find_by_problem_type_id_and_level_number(type.id, checker.level_number)

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



