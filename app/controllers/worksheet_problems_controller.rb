class WorksheetProblemsController < ApplicationController
  def destroy
    @worksheet_problem = WorksheetProblem.find(params[:id])
    @worksheet_problem.destroy
    respond_to do |format|
      format.html { redirect_to(worksheet_url(@worksheet_problem.worksheet)) }
      format.xml  { head :ok }
    end
  end
end
