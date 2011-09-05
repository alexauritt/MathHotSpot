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
    problem_numbers = problem_group.map { |prob| prob.problem_number }
    first_word = problem_numbers.size == 1 ? 'Problem' : 'Problems'
    if is_range? problem_numbers
      numbers_list = range_string problem_numbers
    else
      numbers_list = problem_numbers.join(", ").chomp(', ')
    end
    "#{first_word} ##{numbers_list.chomp}: #{problem_group.first.instruction_description}" 
  end
  
  def is_range?(number_list)
    (number_list.first .. number_list.last).to_a == number_list && number_list.size > 1
  end
  
  def range_string(number_list)
    "#{number_list.first} - #{number_list.last}"
  end
end
