class ProblemLevelsController < ApplicationController
  def show
    @math_problems = ProblemLevel.find(params[:id]).math_problems
  end
end
