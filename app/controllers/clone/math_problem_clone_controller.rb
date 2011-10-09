class Clone::MathProblemCloneController < ApplicationController
  def new
    parent = MathProblem.find(params[:math_problem_id])
    @problem_type = parent.problem_type
    
    @math_problem = parent.dup

    @siblings = parent.siblings(10)
    render "math_problems/new"
  end
end
