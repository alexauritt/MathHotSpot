class Search::ProblemTypesController < ApplicationController
  def index
    @subjects = Subject.all
    @tags = ProblemType.tag_counts_on(:tags)    
  end
end
