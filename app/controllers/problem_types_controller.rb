class ProblemTypesController < ApplicationController

  def index
    @problem_types = ProblemType.search(params[:search])
  end
  
  def show
    @problem_type = ProblemType.find_by_permalink(params[:id])
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
  
  def edit
    @problem_type = ProblemType.find_by_permalink(params[:id])
  end
  
  def update
    @problem_type = ProblemType.find_by_permalink(params[:id])

    respond_to do |format|
      if @problem_type.update_attributes(params[:problem_type])
        format.html { redirect_to(@problem_type, :notice => 'Problem Type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem_type.errors, :status => :unprocessable_entity }
      end
    end    
  end
  
  def destroy
    problem_type = ProblemType.find_by_permalink(params[:id])
    problem_type.destroy
    redirect_to root_url
  end
  
end
