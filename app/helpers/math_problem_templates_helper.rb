module MathProblemTemplatesHelper
  def level_count_msg(template)
    count = template.level_count
    count == 1 ? "1 Level" : "#{count} Levels"
  end

  def problem_count_msg(template)
    count = template.problem_count
    count == 1 ? "1 Problem" : "#{count} Problems"
  end
end