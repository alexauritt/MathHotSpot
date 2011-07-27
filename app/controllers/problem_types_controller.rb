class ProblemTypesController < ApplicationController
  include CurrentLessonManageable

  def index
    redirect_to new_problem_types_search_url
  end
  
  def show
    @current_lesson = current_lesson_specified_in_session!
    @problem_type = ProblemType.find_by_permalink(params[:id])
    render "show_with_current_lesson" if @current_lesson
  end
  
  def new
    @problem_type = ProblemType.new
    @problem_type.build_instruction
    level = @problem_type.problem_levels.build
    level.math_problems.build
  end
  
  def create
    @problem_type = ProblemType.new(params[:problem_type].merge({:owner => current_user }))
    if @problem_type.save
      redirect_to(problem_type_path(@problem_type), :notice => 'Problem Type was successfully created.')
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
