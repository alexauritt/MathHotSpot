module MathHotSpotErrors
  module ProblemReplacementErrors
    class UNIQUE_PROBLEM_REPLACE_ERROR < StandardError; end     
    class NO_SIMILAR_PROBLEMS_REMAINING < StandardError; end
  end  
  module WorksheetErrors
    class UNIQUE_PROBLEM_REPLACE_ERROR < StandardError; end     
    class NO_SIMILAR_PROBLEMS_REMAINING < StandardError; end
        
    module Internal
      class PROBLEM_NUMBER_MISSING_ERROR < StandardError; end
    end
  end
end