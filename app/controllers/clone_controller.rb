class CloneController < ApplicationController
  def new
    parent = MathProblem.find(params[:math_problem_id])
    @problem_type = parent.problem_type
    @problem_levels = @problem_type.problem_levels
    @math_problem = MathProblem.new(:problem_level => parent.problem_level, 
      :question_markup => parent.question_markup, :answer_markup => parent.answer_markup)
    render "math_problems/new"
  end
end
