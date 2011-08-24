class WorksheetBuilderController < ApplicationController
  def create
    @worksheet = WorksheetBuilder.create(params[:worksheet_builder].merge({:owner => current_user }))
    redirect_to @worksheet
  end
end
