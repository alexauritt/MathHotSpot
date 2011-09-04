module WorksheetsHelper
  def display_problem_number(worksheet_problem)
    "#{worksheet_problem.problem_number})"
  end
  
  def problem_links_if_editable(worksheet_problem, editable)
    if editable
      render :partial => "worksheet_problems/worksheet_problem_links", :locals => { :worksheet_problem => worksheet_problem }
    end
  end
  
  def problem_group_instructions(problem_group)
    problem_group.first.instruction_description
    problem_numbers = problem_group.map { |prob| prob.problem_number }
    numbers_list = problem_numbers.join(", ")
    "Problems #{numbers_list.chomp(', ')}: #{problem_group.first.instruction_description}" 
  end
end
