module WorksheetProblemsHelper
  def add_replace_or_create_similar_worksheet_problem_for(worksheet_problem)
    locals = { :worksheet_problem => worksheet_problem }
    if worksheet_problem.replacement_available?
      render :partial => "worksheet_problems/replace_and_add_similar_worksheet_problem_buttons", :locals => locals
    else
      render :partial => 'worksheet_problems/create_similar_problem', :locals => locals
    end
  end
end
