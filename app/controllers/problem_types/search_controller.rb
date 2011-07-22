class ProblemTypes::SearchController < ApplicationController
  def index
    begin
      @current_lesson = session[:current_lesson_id] ? Lesson.find(session[:current_lesson_id]) : nil
    rescue ActiveRecord::RecordNotFound
      session[:current_lesson_id] = nil
    end
    
    @subjects = Subject.all.delete_if {|s| s.problem_types.empty? }
    @tags = ProblemType.tag_counts_on(:tags)
    
    render "index_with_current_lesson" if @current_lesson     
  end
end
