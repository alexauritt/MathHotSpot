class WorksheetSolutionsController < ApplicationController
  def show
    @worksheet = Worksheet.find(params[:id])
    render :template => "worksheets/show"
  end
end
