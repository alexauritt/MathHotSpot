class WorksheetsController < ApplicationController
  def index
    @math_problems = MathProblem.all
    render :template => "worksheets/index.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
  
  def show
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.math_problems
    render :template => "worksheets/show.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
