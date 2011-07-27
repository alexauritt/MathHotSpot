class ProblemTypes::SearchController < ApplicationController
  include CurrentLessonManageable
  def new
    @current_lesson = current_lesson_specified_in_session!
    
    @subjects = Subject.all.delete_if {|s| s.problem_types.empty? }
    @tags = ProblemType.tag_counts_on(:tags)

    render "new_with_current_lesson" if @current_lesson
  end
    
  def show
    @current_lesson = current_lesson_specified_in_session!
    @search = params[:search]
    @problem_types = ProblemType.search(params[:search])
    
    render "show_with_current_lesson" if @current_lesson
  end
  
end
