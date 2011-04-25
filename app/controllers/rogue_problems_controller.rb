class RogueProblemsController < ApplicationController
  def index
    @rogue_problems = MathProblem.rogue_problems    
  end
  
  def new
    @math_problem = MathProblem.new
  end
end
