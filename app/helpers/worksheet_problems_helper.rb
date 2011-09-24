module WorksheetProblemsHelper
  def add_or_create_similar_worksheet_problem_for(worksheet_problem)
    locals = { :worksheet_problem => worksheet_problem }
    worksheet_problem.replacement_available? ? 
      render(:partial => 'worksheet_problems/add_similar_worksheet_problem', :locals => locals) :
      render(:partial => 'worksheet_problems/create_similar_problem', :locals => locals)
  end
end
