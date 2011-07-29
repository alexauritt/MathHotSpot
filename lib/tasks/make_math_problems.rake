PATH = ::Rails.root.to_s + "/tmp/content_generation/"

namespace :make_math do
  desc "check that only one problem_level_id is used in specified yml file"
  task :create => :environment do
    unless ENV['FILE'] && valid_file_specified?(ENV['FILE'])
      raise 'Please input a yml file: rake math_make:create FILE=some_file_name'
    end
    file = ENV['FILE']
    math_problems = YAML.load_file(PATH + file + ".yml")
    if only_one_problem_level_in_file?(math_problems)
      MathProblem.create(math_problems)
    else
      raise "All problems must be from same problem_level."
    end
  end
end

def valid_file_specified?(file)
  File.exists?(PATH + file + ".yml")
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