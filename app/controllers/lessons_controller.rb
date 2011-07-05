class LessonsController < ApplicationController

  # GET /lessons/1
  # GET /lessons/1.xml
  def show
    @lesson = Lesson.find(params[:id])
    @problem_types = @lesson.problem_types
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lesson }
    end
  end
  
  def index
    @lessons = Lesson.find_all_by_owner_id(current_user)
    @problem_types = ProblemType.find_all_by_owner_id(current_user)
  end

end
