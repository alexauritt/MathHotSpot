class ProblemLevelsController < ApplicationController
  def show
    @problem_level = ProblemLevel.find(params[:id])
    @math_problems = @problem_level.math_problems
  end
  
  def new
    @template = MathProblemTemplate.find(params[:math_problem_template_id])
    @problem_level = ProblemLevel.new(:math_problem_template => @template)
    @problem_level.math_problems.build
  end
  
  def create
    @problem_level = ProblemLevel.new(params[:problem_level])
    if @problem_level.save
      redirect_to(math_problem_template_url(@problem_level.math_problem_template), :notice => 'Template was successfully created.')
    else
      render :action => "new"
    end
  end
end
