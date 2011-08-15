class MathProblemsController < ApplicationController  
  def show
    @math_problem = MathProblem.find(params[:id])
  end
  
  def create
    @math_problem = MathProblem.new(params[:math_problem].merge({:owner => current_user }))
    respond_to do |format|
      if @math_problem.save
        format.html { redirect_to(@math_problem, :notice => 'Math Problem was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def new
    @problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    problem_level = ProblemLevel.find_by_level_number_and_problem_type_id(params[:problem_level_id], @problem_type.id)
    @math_problem = MathProblem.new(:problem_level => problem_level)
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
    redirect_to root_url 
  end    
end