class Clone::WorksheetProblemCloneController < ApplicationController
  def new
    parent = WorksheetProblem.find_by_worksheet_id_and_position(params[:worksheet_id].to_i, params[:problem_number].to_i)
    @math_problem = parent.math_problem
    clone = @math_problem.dup
    @worksheet_problem = WorksheetProblem.new(:worksheet => parent.worksheet, :math_problem => clone)
  end
end
