module MathMaker
  class ProblemTypeNotFoundError < StandardError  
    MESSAGE = "Unable to find Problem Type"
  end
  
  class ProblemLevelNotFoundError < StandardError
    MESSAGE = "Unable to find Problem Level"
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
        @problem_type = ProblemType.find_by_title(@title)
        raise ProblemTypeNotFoundError if @problem_type.nil?
        @problem_level = ProblemLevel.find_by_problem_type_id_and_level_number(@problem_type.id, @level_number)        
        raise ProblemLevelNotFoundError if @problem_level.nil?
        true
      rescue ProblemTypeNotFoundError
        puts ProblemTypeNotFoundError::MESSAGE
        false
      rescue ProblemLevelNotFoundError
        puts ProblemLevelNotFoundError::MESSAGE
        false
      end
    end
  end
end