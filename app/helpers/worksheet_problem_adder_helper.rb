module WorksheetProblemAdderHelper
  def displaced_problem_numbers(worksheet, target_problem_number)
    (target_problem_number + 2..worksheet.problem_count).to_a
  end
  
  def problem_numbers_requiring_link_updates(worksheet, target_problem_number)
    new_problem = worksheet.problem(target_problem_number + 1)
    new_problem.replacement_available? ? [] : new_problem.siblings.map { |problem| problem.position }
  end  
end