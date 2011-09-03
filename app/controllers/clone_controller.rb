class CloneController < ApplicationController
  def new
    parent = MathProblem.find(params[:math_problem_id])
    @problem_type = parent.problem_type
    @problem_levels = @problem_type.problem_levels
    @math_problem = parent.clone
    @siblings = parent.siblings(10)
    render "math_problems/new"
  end
end
