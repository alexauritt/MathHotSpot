class ProblemTypeWorksheetBuilderController < ApplicationController
  def new
    @problem_type = ProblemType.find_by_permalink params[:permalink]
    @builder = ProblemTypeWorksheetBuilder.new(:problem_levels => @problem_type.problem_levels)
  end
  
  def create
    @worksheet = Worksheet.create(:title => params[:worksheet_builder][:title], :owner => current_user)
    redirect_to @worksheet
  end
end
