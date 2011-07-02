module ProblemTypesHelper
  include ActsAsTaggableOn::TagsHelper

  def level_count_msg(problem_type)
    count = problem_type.level_count
    count == 1 ? "1 Level" : "#{count} Levels"
  end

  def problem_count_msg(problem_type)
    count = problem_type.problem_count
    count == 1 ? "1 Problem" : "#{count} Problems"
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

  def delete_problem_type_link_if_empty(type)
    type.problem_levels.empty? ? link_to('Delete Problem Type', problem_type_path(type), :confirm => "Are you sure?", :method => :delete) : ""
  end

  def empty_problem_type_message
    MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE
  end
end