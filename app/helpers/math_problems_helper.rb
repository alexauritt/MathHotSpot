module MathProblemsHelper
  
  def display_mathml_question(math_problem)
    display_mathml(math_problem, true)
  end

  def display_mathml_answer(math_problem)
    display_mathml(math_problem, false)
  end
  
  def display_mathml(problem, display_question = true)
    unless problem
      MathHotSpotErrors::Message::NO_SAMPLE_MATH_PROBLEM_FOUND
    else
      markup = display_question ? problem.question_markup : problem.answer_markup
      text = display_question ? "question" : "answer"
      unless markup.nil?
        start_tag, end_tag = "<p class='inline_math'>","</p>"
        problem.display_mode? ? markup.html_safe : start_tag.concat(markup).concat(end_tag).html_safe
      else
        "No #{text} specified."
      end
    end
  end
  
  def display_solution(problem)
    display_mathml(problem, false)
  end
    
  def problem_type_count_msg(count)
    count > 1 ? "(#{count} problem types)" : "(1 problem type)"
  end

  def sibling_count(siblings, total_count)
    if (total_count == siblings)
      last_word = siblings == 1 ? "problem" : "problems"
      "(#{total_count} #{last_word})"
    else
      "(#{siblings} of #{total_count} problems)"
    end
  end
  
  def add_to_current_worksheet_link_if_applicable(math_problem)
    if current_worksheet?
      begin
        current_worksheet = Worksheet.find(session[:current_worksheet_id])
        unless current_worksheet.math_problems.include? math_problem
          render(:partial => "math_problems/add_math_problem_to_current_worksheet", :locals => {:math_problem => math_problem, :current_worksheet_id => session[:current_worksheet_id]})
        end
      rescue ActiveRecord::RecordNotFound
        clear_current_worksheet_in_session!
      end
    end
  end  
end
