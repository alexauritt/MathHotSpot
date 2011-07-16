class Search::ProblemTypesController < ApplicationController
  def index
    @current_lesson = session[:current_lesson_id] ? Lesson.find(session[:current_lesson_id]) : nil
    @subjects = Subject.all
    @tags = ProblemType.tag_counts_on(:tags)    
  end
end
