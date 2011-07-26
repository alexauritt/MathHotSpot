class CoreLessonProblemTypesController < ApplicationController
  def create
    @core = CoreLessonProblemType.new(params[:core_lesson_problem_type])
    message = @core.save ? "Successfully added ProblemType to Lesson." : "Unable to add Problem Type to Lesson"
    if @core.lesson
      redirect_to(lesson_path(@core.lesson), :notice => message )
    else
      Rails.logger.error("Attempt to add problem type to non-existent lesson")
      redirect_to(new_problem_types_search_path, :notice => message)
    end
  end
end
