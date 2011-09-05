class WorksheetProblemAdderController < ApplicationController
  def create
    @worksheet = Worksheet.find(params[:worksheet_problem_adder][:worksheet_id])
    @worksheet.add_problem_like(params[:worksheet_problem_adder][:problem_number].to_i)
    # problems_of_this_type_on_worksheet = get all math problems from same level as prob above on worksheet
    # MathProblem.find_problem_like(problem, :exclude => )
    render :text => "finished"
  end
end
