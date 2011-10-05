module WorksheetProblemsHelper
  def add_replace_or_create_similar_worksheet_problem_for(worksheet_problem)
    locals = { :worksheet_problem => worksheet_problem }
    if worksheet_problem.replacement_available?
      render :partial => "worksheet_problems/replace_and_add_similar_worksheet_problem_buttons", :locals => locals
    else
      render :partial => 'worksheet_problems/create_similar_problem', :locals => locals
    end
  end
  
  def display_level_link_if_classified!(worksheet_problem)
    if worksheet_problem.classified?
      render :partial => "worksheet_problems/level_link", :locals => { :worksheet_problem => worksheet_problem }
    end
  end
  
  def display_level_info_if_classified!(worksheet_problem)
    if worksheet_problem.classified?
      render :partial => "worksheet_problems/type_and_level_info", :locals => {:worksheet_problem => worksheet_problem }
    end
  end
end
