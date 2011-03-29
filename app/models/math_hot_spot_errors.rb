module MathHotSpotErrors
  module ProblemReplacementErrors
    class UNIQUE_PROBLEM_REPLACE_ERROR < StandardError; end     
    class NO_SIMILAR_PROBLEMS_REMAINING < StandardError; end
    class PROBLEM_NUMBER_MISSING_ERROR < StandardError; end
  end
end