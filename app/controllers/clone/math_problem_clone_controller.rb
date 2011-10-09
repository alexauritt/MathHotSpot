class Clone::MathProblemCloneController < ApplicationController
  def new
    parent = MathProblem.find(params[:math_problem_id])
    @problem_type = parent.problem_type
    
    new_prob_attrs = {:problem_level => parent.problem_level, :question_markup => parent.question_markup, :answer_markup => parent.answer_markup}
    @math_problem = MathProblem.new new_prob_attrs

    @siblings = parent.siblings(10)
    render "math_problems/new"
  end
end
