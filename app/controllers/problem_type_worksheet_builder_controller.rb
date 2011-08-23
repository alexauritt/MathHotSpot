class ProblemTypeWorksheetBuilderController < ApplicationController
  def show
    @problem_type = ProblemType.find_by_permalink params[:permalink]
    @builder = ProblemTypeWorksheetBuilder.new(:problem_levels => @problem_type.problem_levels)
  end
end
