class LessonWorksheetBuilderController < ApplicationController
  def new
    @lesson = Lesson.find(params[:id])
    @problem_types = @lesson.problem_types
    redirect_to(lesson_path(@lesson), :notice => MathHotSpotErrors::Message::LESSON_NEEDS_PROBLEM_TYPES_FOR_WORKSHEET) if @lesson.empty?
  end
end
