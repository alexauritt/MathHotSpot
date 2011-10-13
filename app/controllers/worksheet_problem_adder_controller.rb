class WorksheetProblemAdderController < ApplicationController
  def create
    @worksheet = Worksheet.find(params[:worksheet_problem_adder][:worksheet_id].to_i)
    @target_problem_number = params[:worksheet_problem_adder][:problem_number].to_i
    @new_worksheet_problem = @worksheet.add_problem_like!(@target_problem_number)
    unless @new_worksheet_problem
      @worksheet.errors[:base].each { |error| flash.now[:notice] = error }
    end
    respond_to do |format|
      format.html { redirect_to edit_worksheet_path(@worksheet), :notice => flash.now[:notice ] }
      format.js
    end    
  end
end
