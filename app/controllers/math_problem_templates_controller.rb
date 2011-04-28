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
      redirect_to("/", :notice => 'Template was successfully created.')
    else
      Rails.logger.error "Error isy #{@template.errors}"
      render :action => "new"
    end
  end
end
