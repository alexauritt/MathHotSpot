class WorksheetProblemAdderController < ApplicationController
  def create
    @worksheet = Worksheet.find(params[:worksheet_problem_adder][:worksheet_id].to_i)
    unless @worksheet.add_problem_like!(params[:worksheet_problem_adder][:problem_number].to_i)
      @worksheet.errors[:base].each { |error| flash.now[:notice] = error }
    end
    redirect_to edit_worksheet_path(@worksheet), :notice => flash.now[:notice ]
  end
end
