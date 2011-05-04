class ProblemTypesController < ApplicationController
  def show
    @problem_type = ProblemType.find(params[:id])
  end
  
  def new
    @problem_type = ProblemType.new
    @problem_type.build_instruction
    @problem_type.lesson = Lesson.find(params[:lesson_id])
    level = @problem_type.problem_levels.build
    level.math_problems.build
  end
  
  def create
    @problem_type = ProblemType.new(params[:problem_type])
    if @problem_type.save
      redirect_to(lesson_url(@problem_type.lesson), :notice => 'Problem Type was successfully created.')
    else
      render :action => "new"
    end
  end
end
