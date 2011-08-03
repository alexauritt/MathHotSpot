require "content_generation/math_problem_yaml_text_creator"

class Shuffler < Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end

module MathMaker
  class ProblemTypeNotFoundError < StandardError  
  end
  
  class ProblemLevelNotFoundError < StandardError
  end
  
  class ProblemExistenceChecker
    attr_reader :problem_level, :level_number, :problem_type, :problem_type_title

    def initialize(title, level_number)
      @title = title
      @level_number = level_number
    end
    
    def problem_type
      @problem_type ||= (@title.nil? ? ProblemType.find_by_title(@title) : nil)
    end
    
    def problem_type_and_level_in_db?
      begin
        @problem_type ||= ProblemType.find_by_title(@title)
        raise if @problem_type.nil?
        @problem_level ||= ProblemLevel.find_by_problem_type_id_and_level_number(@problem_type.id, @level_number)        
        raise if @problem_level.nil?
        true
      rescue ProblemTypeNotFoundError
        puts "Unable to find Problem Type"
        false
      rescue ProblemLevelNotFoundError
        puts "Unable to find Problem Level"
        false
      end
    end
  end
end