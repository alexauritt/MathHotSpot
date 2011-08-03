require "content_generation/math_problem_yaml_text_creator"

class Shuffler < Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end

module MathMaker
  class ProblemExistenceChecker
    def initialize(title, level_number)
      @title = title
      @level_number = level_number
    end
    def problem_type_and_level_in_db?
      begin
        type = ProblemType.find_by_title(@title)
        raise if type.nil?
        level = ProblemLevel.find_by_problem_type_id_and_level_number(type.id, @level_number)
        raise if level.nil?
        true
      rescue
        puts "Unable to find Problem Type / Level specified"
        false
      end
    end
  end
end