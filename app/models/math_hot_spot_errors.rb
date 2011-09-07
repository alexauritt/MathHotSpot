module RightRabbitErrors
  UNIQUE_PROBLEM_ERROR = "Problem is one of a kind"
  NONE_REMAINING = "All problems already present on worksheet"
  DEFAULT = "An unknown error has occured"
  
  NO_INSTRUCTIONS = "No instructions provided."
  NO_LEVEL_NUMBER = "No level_number level specified."
  
  NO_SAMPLE_MATH_PROBLEM_FOUND = "No Sample Math Problem was found"
  
  NO_LEVEL_DELETE = "Unable to delete level. (Perhaps the level was not empty.)"
  NO_LEVEL_CREATE = 'Unable to create Problem Level. Does that level number already exist?'
  
  NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE = "No math problems are defined for this problem type. Please add some math problems!"
  NO_INSTRUCTIONS_SPECIFIED = "No instructions specified."
  
  LESSON_NEEDS_PROBLEM_TYPES_FOR_WORKSHEET = 'This Lesson is empty. Please add Problem Types to this Lesson before creating a Worksheet.'  
  class UniqueProblemError < StandardError; def message; UNIQUE_PROBLEM_ERROR; end; end  
  class ProblemNumberMissing < StandardError; end
end



module MathHotSpotErrors
  module WorksheetModifierErrors
    module Messages
      PROBLEM_NUMBER_MISSING_FOR_ADD_LIKE = "Unable to add new problem."
    end
  end
  module ProblemReplacementErrors
    class UNIQUE_PROBLEM_REPLACE_ERROR < StandardError; end     
    class NO_SIMILAR_PROBLEMS_REMAINING < StandardError; end
    class PROBLEM_NUMBER_MISSING_ERROR < StandardError; end
  end
    
  class Message
    UNIQUE = "Problem is one of a kind"
    NONE_REMAINING = "All problems already present on worksheet"
    DEFAULT = "An unknown error has occured"
    
    NO_INSTRUCTIONS = "No instructions provided."
    NO_LEVEL_NUMBER = "No level_number level specified."
    
    NO_SAMPLE_MATH_PROBLEM_FOUND = "No Sample Math Problem was found"
    
    NO_LEVEL_DELETE = "Unable to delete level. (Perhaps the level was not empty.)"
    NO_LEVEL_CREATE = 'Unable to create Problem Level. Does that level number already exist?'
    
    NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE = "No math problems are defined for this problem type. Please add some math problems!"
    NO_INSTRUCTIONS_SPECIFIED = "No instructions specified."
    
    LESSON_NEEDS_PROBLEM_TYPES_FOR_WORKSHEET = 'This Lesson is empty. Please add Problem Types to this Lesson before creating a Worksheet.'
    
    @message = {
      ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR => UNIQUE,
      ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING => NONE_REMAINING,
      ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR => DEFAULT
    }
    
    def self.display(error)
      @message[error.class]
    end
  end
  
  class EmptyProblem
    def self.question_markup
      MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE
    end
    def self.answer_markup
      ""
    end
    def self.display_mode?
      false
    end
    def self.instruction_text
      MathHotSpotErrors::Message::NO_INSTRUCTIONS_SPECIFIED
    end
  end
end