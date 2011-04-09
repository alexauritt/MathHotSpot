class MathProblemsController < ApplicationController
  def index
    @problem_groups = MathProblem.group_all_by_template
  end
  
  def show
    @math_problem = MathProblem.find(params[:id])
  end
  
  def create
    @math_problem = MathProblem.new(params[:math_problem])
    respond_to do |format|
      if @math_problem.save
        format.html { redirect_to(@math_problem, :notice => 'Math Problem was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def new
    @math_problem = MathProblem.new
  end

  def grouped
    @problem_groups = MathProblem.group_all_by_template
  end
  
  def rougue
    @rougue_problems = MathProblem.rougue_problems
  end
    
end