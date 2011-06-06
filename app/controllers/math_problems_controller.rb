class MathProblemsController < ApplicationController  
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
    problem_level = ProblemLevel.find(params[:problem_level_id])
    @math_problem = MathProblem.new(:problem_level => problem_level)
    @problem_type = problem_level.problem_type
  end

  def edit
    @math_problem = MathProblem.find(params[:id])
    @problem_type = @math_problem.problem_type
  end
  
  def update
    @math_problem = MathProblem.find(params[:id])
    if @math_problem.update_attributes(params[:math_problem])
      redirect_to(@math_problem, :notice => 'Math problem successfully updated')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @math_problem = MathProblem.find(params[:id])
    @math_problem.destroy
    redirect_to menu_url 
  end    
end