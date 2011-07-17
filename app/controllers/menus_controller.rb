class MenusController < ApplicationController
  
  def tag_menu
    @tag = params[:tag]
    @problem_types = ProblemType.tagged_with(@tag)
  end
end
