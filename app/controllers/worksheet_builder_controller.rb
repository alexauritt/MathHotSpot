class WorksheetBuilderController < ApplicationController
  def create
    @worksheet = WorksheetBuilder.build(params[:worksheet_builder].merge({:owner => current_user }))
    if @worksheet.save
      redirect_to @worksheet, :notice => "New Worksheet!"
    else      
      redirect_to root_path, :notice => "Error creating new Worksheet."
    end
  end
end
