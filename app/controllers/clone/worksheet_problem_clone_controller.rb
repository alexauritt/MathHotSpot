class Clone::WorksheetProblemCloneController < ApplicationController
  def new
    parent = WorksheetProblem.find_by_worksheet_id_and_problem_number(params[:worksheet_id].to_i, params[:problem_number].to_i)
    @math_problem = parent.math_problem
    new_prob_attrs = {:problem_level => @math_problem.problem_level, :question_markup => @math_problem.question_markup, :answer_markup => @math_problem.answer_markup}
    clone = MathProblem.new new_prob_attrs
    @worksheet_problem = WorksheetProblem.new(:worksheet => parent.worksheet, :math_problem => clone)
  end
end
