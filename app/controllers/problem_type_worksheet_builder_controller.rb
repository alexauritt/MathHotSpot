class ProblemTypeWorksheetBuilderController < ApplicationController
  def new
    @problem_type = ProblemType.find_by_permalink params[:permalink]
    @builder = ProblemTypeWorksheetBuilder.new(:problem_levels => @problem_type.problem_levels)
  end
  
  def create
    redirect_to root_path
  end
end
