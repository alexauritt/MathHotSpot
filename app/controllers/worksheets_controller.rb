class WorksheetsController < ApplicationController
  def index
    @worksheets = Worksheet.all
  end
  
  def create
    @worksheet = Worksheet.new(params[:worksheet].merge({:owner => current_user }))
    respond_to do |format|
      if @worksheet.save
        format.html { redirect_to(@worksheet, :notice => 'Worksheet was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end 
  end
  
  def show
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem }
  end
  
  def edit
    @worksheet = Worksheet.find(params[:id])
    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem }
  end

  def update    
    @worksheet = Worksheet.find(params[:id])
    @problem_number = params[:problem_number].to_i
    @success = @worksheet.replace_problem(@problem_number)
    unless @success
      @error_msg = @worksheet.error_for_failed_replace
      flash.now[:notice] = @error_msg
    end

    @math_problems = @worksheet.worksheet_problems.map {|wp| wp.math_problem}
    @new_problem = @math_problems[@problem_number - 1]
    respond_to do |format|
      format.html { render :template => "worksheets/show" }
      format.js
    end
  end
end
