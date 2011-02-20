class WorksheetsController < ApplicationController
  def index
    @worksheets = Worksheet.all
    render :template => "worksheets/index.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
  
  def show
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.math_problems
    render :template => "worksheets/show.xhtml.erb", :content_type => 'application/xhtml+xml'
  end

  def update
    @worksheet = Worksheet.find(params[:id])
    old_problem = MathProblem.find(params[:math_problem_id])
    new_problem = MathProblemTemplate.find_replacement(old_problem)
    @worksheet.math_problems.delete old_problem 
    @worksheet.math_problems << new_problem
    @worksheet.save
    @math_problems = @worksheet.math_problems
    render :template => "worksheets/show.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
