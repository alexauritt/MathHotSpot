module WorksheetsHelper
  def display_problem_number(worksheet_problem)
    "#{worksheet_problem.problem_number})"
  end
  
  def problem_links_if_editable(worksheet_problem, editable)
    if editable
      render :partial => "worksheet_problems/worksheet_problem_links", :locals => { :worksheet_problem => worksheet_problem }
    end
  end  
end
