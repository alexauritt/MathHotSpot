class WorksheetProblemAdderController < ApplicationController
  def create
    @worksheet = Worksheet.find(params[:worksheet_problem_adder][:worksheet_id])
    unless @worksheet.add_problem_like!(params[:worksheet_problem_adder][:problem_number].to_i)
      @worksheet.errors[:base].each { |error| flash.now[:notice] = error }
    end
    render :template => "worksheets/show"
  end
end
