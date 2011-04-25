class ProblemLevelsController < ApplicationController
  def show
    @problem_level = ProblemLevel.find(params[:id])
    @math_problems = @problem_level.math_problems
  end
end
