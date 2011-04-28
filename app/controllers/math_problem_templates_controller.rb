class MathProblemTemplatesController < ApplicationController
  def show
    @template = MathProblemTemplate.find(params[:id])
  end
  
  def new
    @template = MathProblemTemplate.new
    level = @template.problem_levels.build
    level.math_problems.build
  end
  
  def create
    @template = MathProblemTemplate.new(params[:math_problem_template])
    if @template.valid? && @template.save
      redirect_to(lesson_url(@template.lesson), :notice => 'Template was successfully created.')
    else
      render :action => "new"
    end
  end
end
