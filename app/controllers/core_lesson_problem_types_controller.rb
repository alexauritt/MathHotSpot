class CoreLessonProblemTypesController < ApplicationController
  def create
    @core = CoreLessonProblemType.new(params[:core_lesson_problem_type])
    @core.save
    redirect_to lesson_path(@core.lesson)
  end
end
