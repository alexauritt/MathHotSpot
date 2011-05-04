class ProblemLevelsController < ApplicationController
  def show
    @problem_level = ProblemLevel.find(params[:id])
    @math_problems = @problem_level.math_problems
  end
  
  def new
    @problem_type = ProblemType.find(params[:problem_type_id])
    @sibling_levels = @problem_type.problem_levels
    @problem_level = ProblemLevel.new(:problem_type => @problem_type)
    @problem_level.math_problems.build
  end
  
  def create
    @problem_level = ProblemLevel.new(params[:problem_level])
    if @problem_level.save
      redirect_to(problem_type_url(@problem_level.problem_type), :notice => 'Template was successfully created.')
    else
      render :action => "new"
    end
  end
end
