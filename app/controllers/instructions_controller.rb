class InstructionsController < ApplicationController
  
  def new
    @instruction = Instruction.new
  end
  
  def create
    @instruction = Instruction.new(params[:instruction])
    @lesson = Lesson.find(params[:lesson_id])
    if @instruction.save
      redirect_to(new_problem_type_path, :notice => 'Instruction was successfully created.') 
    else
      render :action => "new", :notice => "There was an error."
    end
  end
end
