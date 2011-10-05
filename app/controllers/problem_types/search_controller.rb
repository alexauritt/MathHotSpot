class ProblemTypes::SearchController < ApplicationController
  include CurrentAssetManageable

  def new
    @current_asset = current_asset_specified_in_session!
    
    @subjects = Subject.all.delete_if {|s| s.problem_types.empty? }
    @tags = ProblemType.tag_counts_on(:tags)

    render "new_with_current_asset" if @current_asset
  end
    
  def show
    @current_asset = current_asset_specified_in_session!
    @search = params[:search]
    @problem_types = ProblemType.search(params[:search])
    
    render "show_with_current_asset" if @current_asset
  end
  
end
