
require_relative '../content_generation/math_problem_yaml_reader'
  
namespace :make_math do
  
  desc "check that only one problem_level_id is used in specified yml file"
  task :create => :environment do
    if valid_input_file_specified?
      file = ENV['FILE']
      expected_yml_target = Rails.root.to_s + "/tmp/content_generation/" + file + ".yml"
      math_problems = YAML.load_file(expected_yml_target)
      if only_one_problem_level_in_file?(math_problems)
        MathProblem.create(math_problems)
      else
        raise "All problems must be from same problem_level."
      end
    end
  end
end

def valid_input_file_specified?
  unless ENV['FILE']
    puts 'Please input a yml file: rake math_make:create FILE=some_file_name'
    false
  else
    true
  end
end

def only_one_problem_level_in_file?(problem_specs)
  level_id = problem_specs.first['problem_level_id']
  flag = true
  problem_specs.each do |prob|
    if prob['problem_level_id'] != level_id
      flag = false 
    end
  end
  flag
end