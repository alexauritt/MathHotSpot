class RogueProblemsController < ApplicationController
  def index
    @rogue_problems = MathProblem.rogue_problems    
  end
end
