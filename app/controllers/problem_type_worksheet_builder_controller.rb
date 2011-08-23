class ProblemTypeWorksheetBuilderController < ApplicationController
  def show
    @problem_type = ProblemType.find_by_permalink params[:permalink]
    render :text => "I will help you build a worksheet with stuff from #{@problem_type.title}"
  end
end
