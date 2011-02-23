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
    
    if @worksheet.replace_problem(params[:problem_number].to_i)
      flash[:notice] = "Problem successfully replaced."
    else
      flash[:notice] = @worksheet.error_for_failed_replace.to_s
    end
  
    @worksheet.save
    @math_problems = @worksheet.math_problems
      
    render :template => "worksheets/show.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
