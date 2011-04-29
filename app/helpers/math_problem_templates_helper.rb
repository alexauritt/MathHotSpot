module MathProblemTemplatesHelper
  def level_count_msg(template)
    count = template.level_count
    count == 1 ? "1 Level" : "#{count} Levels"
  end

  def problem_count_msg(template)
    count = template.problem_count
    count == 1 ? "1 Problem" : "#{count} Problems"
  end
  
  def instruction_choices
    Instruction.order("created_at DESC").all.collect {|instruction| [instruction.description, instruction.id ]}
  end
end