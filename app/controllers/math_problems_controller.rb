class MathProblemsController < ApplicationController
  def index
    @math_problems = MathProblem.all
  end
end