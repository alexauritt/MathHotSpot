class WorksheetsController < ApplicationController
  def index
    @worksheets = Worksheet.all
    render :template => "worksheets/index.xhtml.erb", :layout => "application.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
  
  def show
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem }
    render :template => "worksheets/show.xhtml.erb", :layout => "application.xhtml.erb", :content_type => 'application/xhtml+xml'
  end

  def update
    @worksheet = Worksheet.find(params[:id])
    
    flash.now[:notice] = @worksheet.error_for_failed_replace unless @worksheet.replace_problem(params[:problem_number].to_i)
    number = params[:problem_number].to_i

    @worksheet.save
    @worksheet.reload
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem}
    respond_to do |format|
      format.html { render :template => "worksheets/show.xhtml.erb", :layout => "application.xhtml.erb", :content_type => 'application/xhtml+xml' }
      format.js
    end
  end
end
