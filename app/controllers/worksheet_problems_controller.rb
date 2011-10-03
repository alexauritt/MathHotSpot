class WorksheetProblemsController < ApplicationController
  def destroy
    @worksheet_problem = WorksheetProblem.find(params[:id])
    @worksheet_problem.destroy
    respond_to do |format|
      format.html { redirect_to edit_worksheet_url(@worksheet_problem.worksheet) }
      format.xml  { head :ok }
    end
  end
  
  def create
    params[:worksheet_problem][:math_problem_attributes][:owner] = current_user
    worksheet = Worksheet.find params[:worksheet_problem][:worksheet_id]
    @worksheet_problem = WorksheetProblem.new(params[:worksheet_problem].merge({:problem_number => worksheet.next_available_problem_number}))
    if @worksheet_problem.save
      redirect_to(edit_worksheet_path(worksheet), :notice => 'Problem Type was successfully created.')
    else
      redirect_to(edit_worksheet_path(worksheet), :notice => 'Unable to create new worksheet problem.')
    end
  end
  
  def new
    @worksheet = Worksheet.find params[:worksheet_id]
    @worksheet_problem = @worksheet.worksheet_problems.build
    @math_problem = @worksheet_problem.build_math_problem
  end
end
