module ProblemTypesHelper
  include ActsAsTaggableOn::TagsHelper
  include CurrentAssetManageable

  def level_count_msg(problem_type)
    count = problem_type.level_count
    count == 1 ? "1 Level" : "#{count} Levels"
  end

  def category_choices
    cats = Category.order("subject_id")
    cats.collect {|category| [category.name, category.id]}
  end
  
  def instruction_choices
    Instruction.order("created_at DESC").all.collect {|instruction| [instruction.description, instruction.id ]}
  end
  
  def display_tag_list(problem_type)
    tag_list = problem_type.tag_list.map {|tag| "<span class='tag'>#{tag}</span>"}
    tag_list.empty? ? "" : "Tags: ".concat(tag_list.join).html_safe
  end
  
  def delete_level(level)
    level.math_problems.empty? ? link_to('Delete Level', problem_type_problem_level_path(level.problem_type, level), :confirm => 'Are you sure?', :method => :delete) : ""
  end

  def add_to_current_lesson_link_if_applicable(problem_type)
    if current_lesson?
      begin
        current_lesson = Lesson.find(session[:current_lesson_id])
        unless current_lesson.problem_types.include? problem_type
          render(:partial => "problem_types/add_problem_type_to_current_lesson", :locals => {:problem_type => problem_type, :lesson => current_lesson})
        end
      rescue ActiveRecord::RecordNotFound
        clear_current_lesson_in_session!        
      end
    end
  end

  def delete_problem_type_link_if_empty(type)
    type.problem_levels.empty? ? render(:partial => "problem_types/delete_problem_type", :locals => {:type => type}) : ""
  end

  def empty_problem_type_message
    MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE
  end
  
  def display_problem_levels_or_empty_message(problem_levels)
    unless problem_levels.empty?
      render :partial => "problem_levels/problem_level_example", :collection => problem_levels
    else
      empty_problem_type_message
    end
  end
end