class WorksheetSolutionsController < ApplicationController
  def show
    @worksheet = Worksheet.find(params[:id])
  end
end
