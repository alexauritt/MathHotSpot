class ProblemLevelsController < ApplicationController
  include CurrentAssetManageable

  def show
    @current_asset = current_asset_specified_in_session!
    
    problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    @problem_level = ProblemLevel.find_by_level_number_and_problem_type_id(params[:id], problem_type.id)
    @math_problems = @problem_level.math_problems.page(params[:page])
  end
  
  def new
    @problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    @sibling_levels = @problem_type.problem_levels
    @problem_level = ProblemLevel.new(:problem_type => @problem_type)
    @problem_level.math_problems.build
  end
  
  def create
    set_current_user_as_owner_of_new_nested_math_problems!
    @problem_level = ProblemLevel.new(params[:problem_level])
    @problem_level.problem_type.problem_levels.build  # ahhh! ick! required to prevent problem_type from being 'blank' when we are creating first level. unclear why this is the case.
    if @problem_level.save
      redirect_to(problem_type_url(@problem_level.problem_type), :notice => 'Problem Level was successfully created.')
    else
      redirect_to(problem_type_url(@problem_level.problem_type.permalink), :notice => MathHotSpotErrors::Message::NO_LEVEL_CREATE)
    end
  end
  
  def update
    @problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    @problem_level = ProblemLevel.find_by_level_number_and_problem_type_id(params[:id], @problem_type.id)
    notice = @problem_level.update_attributes(params[:problem_level]) ? "Problem Level successfully updated." : "Unable to update Problem Level."
    redirect_to(problem_type_url(@problem_type), :notice => notice)      
  end

  def destroy
    problem_type = ProblemType.find_by_permalink(params[:problem_type_id])
    @problem_level = ProblemLevel.find_by_level_number_and_problem_type_id(params[:id], problem_type.id)
    @problem_level.destroy
    redirect_to problem_type_url(problem_type)
  end
  
  private
  def set_current_user_as_owner_of_new_nested_math_problems!
    if params[:problem_level][:math_problems_attributes]
      params[:problem_level][:math_problems_attributes].each_value do |prob_attr|
        prob_attr[:owner_id] = current_user.id
      end
    end
  end

end
