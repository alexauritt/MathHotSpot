module WorksheetProblemAdderHelper
  def problem_numbers_to_update(worksheet, options)
    (options[:target_problem_number] + 2..worksheet.problem_count).to_a
  end
  
  def problem_numbers_requiring_link_updates(worksheet, options)
    new_problem = worksheet.problem(options[:target_problem_number] + 1)
    new_problem.replacement_available? ? [] : new_problem.siblings.map { |problem| problem.position }
  end
end