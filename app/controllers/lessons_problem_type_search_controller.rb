class LessonsProblemTypeSearchController < ApplicationController
  def new
    @subjects = Subject.all
    @tags = ProblemType.tag_counts_on(:tags)
    @current_lesson = Lesson.find(params[:lesson_id])
  end
  
  def show
    @lesson = Lesson.find(params[:lesson_id])
  end
end
