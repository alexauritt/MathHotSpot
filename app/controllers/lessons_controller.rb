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
    @lessons = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lessons }
    end
  end
  
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(params[:lesson].merge({:owner => current_user }))
    if @lesson.save
      redirect_to(my_lessons_path, :notice => 'Lesson was successfully created.')
    else
      redirect_to new_lesson_path
    end
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      redirect_to lesson_path(@lesson), :notice => "Lesson was successfully updated."
    else
      render :action => :edit
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def destroy
     @lesson = Lesson.find(params[:id])
     @lesson.destroy
    redirect_to my_lessons_path
  end

end
