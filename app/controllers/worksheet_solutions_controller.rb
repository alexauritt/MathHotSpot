class WorksheetSolutionsController < ApplicationController
  def show
    @worksheet = Worksheet.find(params[:id])
    render :action => "worksheets/show"
  end
end
