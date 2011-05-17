class MenusController < ApplicationController
  def index
    @subjects = Subject.all
    @tags = ProblemType.tag_counts_on(:tags)
  end
  
  def tag_menu
    @tag = params[:tag]
    @problem_types = ProblemType.tagged_with(@tag)
  end
end
