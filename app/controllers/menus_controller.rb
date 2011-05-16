class MenusController < ApplicationController
  def index
    @subjects = Subject.all
    @tags = ProblemType.tag_counts_on(:tags)
  end
  
  def tag_menu
    @problem_types = ProblemType.tagged_with(params[:tag])
  end
end
