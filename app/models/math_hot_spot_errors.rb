module MathHotSpotErrors
  module ProblemReplacementErrors
    class UNIQUE_PROBLEM_REPLACE_ERROR < StandardError; end     
    class NO_SIMILAR_PROBLEMS_REMAINING < StandardError; end
    class PROBLEM_NUMBER_MISSING_ERROR < StandardError; end
  end
  
  # def message
  #   "Error Message Here"
  # end
  
  class Message
    UNIQUE = "Problem is one of a kind"
    NONE_REMAINING = "All problems already present on worksheet"
    DEFAULT = "An unknown error has occured"
    
    NO_INSTRUCTIONS = "No instructions provided."
    
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
    MARKUP = "No problem defined for this problem."
  end
end