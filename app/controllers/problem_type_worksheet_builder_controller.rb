class ProblemTypeWorksheetBuilderController < ApplicationController
  def new
    @problem_type = ProblemType.find_by_permalink params[:permalink]
  end
end
