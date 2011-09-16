class Clone::WorksheetProblemCloneController < ApplicationController
  def new
    parent = WorksheetProblem.find_by_worksheet_id_and_problem_number(params[:worksheet_id], params[:problem_number])
    @math_problem = parent.math_problem
    @problem_type = @math_problem.problem_type
    clone = @math_problem.clone
    @worksheet_problem = WorksheetProblem.new(:worksheet => parent.worksheet, :math_problem => clone)
  end
end
