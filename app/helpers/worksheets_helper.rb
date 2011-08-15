module WorksheetsHelper

  def problem_links_if_editable(worksheet, problem_number, editable)
    if editable
      render :partial => "worksheets/worksheet_problem_links", :locals => { :worksheet => worksheet, :problem_number => problem_number }
    end
  end
end
