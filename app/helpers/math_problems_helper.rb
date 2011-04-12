module MathProblemsHelper
  def display_mathml(math_problem)
    markup = math_problem.question_markup
    start_tag, end_tag = "<p class='inline_math'>","</p>"
    math_problem.display_mode? ? markup.html_safe : start_tag.concat(markup).concat(end_tag).html_safe
  end
end
