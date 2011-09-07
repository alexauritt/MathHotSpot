class WorksheetProblemReplacerController < ApplicationController
  def create
    @worksheet = Worksheet.find(params[:worksheet_problem_replacer][:worksheet_id])
    @problem_number = params[:worksheet_problem_replacer][:problem_number].to_i
    @success = @worksheet.replace_problem(@problem_number)
    @error_msg = nil
    unless @success
      @error_msg = @worksheet.error_for_failed_replace
    end

    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem}
    @new_problem = @math_problems[@problem_number - 1]
    respond_to do |format|
      format.html { redirect_to edit_worksheet_path(@worksheet), :notice => @error_msg }
      format.js
    end
  end
end
