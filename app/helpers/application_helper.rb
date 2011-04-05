module ApplicationHelper
  def display_mathml(math_problem)
    math_problem.question_markup.html_safe
  end
end
