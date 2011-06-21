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
    level.math_problems.empty? ? link_to('Delete Level', problem_type_problem_level_path(level.problem_type.permalink, level.level_number), :confirm => 'Are you sure?', :method => :delete) : ""
  end
end