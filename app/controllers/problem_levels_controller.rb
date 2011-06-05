class ProblemLevelsController < ApplicationController
  def show
    @problem_level = ProblemLevel.find(params[:id])
    @math_problems = @problem_level.math_problems
  end
  
  def new
    @problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    @sibling_levels = @problem_type.problem_levels
    @problem_level = ProblemLevel.new(:problem_type => @problem_type)
    @problem_level.math_problems.build
  end
  
  def create
    @problem_level = ProblemLevel.new(params[:problem_level])
    if @problem_level.save
      redirect_to(problem_type_url(@problem_level.problem_type), :notice => 'Problem Type was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    @problem_level = ProblemLevel.find(params[:id])
    notice = @problem_level.update_attributes(params[:problem_level]) ? "Problem Level successfully updated." : "Unable to update Problem Level."
    @problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    redirect_to(problem_type_url(@problem_type), :notice => notice)      
  end
end
