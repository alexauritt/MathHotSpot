class ProblemTypeWorksheetBuilderController < ApplicationController
  def new
    @problem_type = ProblemType.find_by_permalink params[:permalink]
  end
  
  def create
    @worksheet = ProblemTypeWorksheetBuilder.create(params[:worksheet_builder].merge({:owner => current_user }))
    redirect_to @worksheet
  end
end
