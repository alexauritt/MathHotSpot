module ApplicationHelper
  def display_mathml(math_problem)
    math_problem.problem_markup.html_safe
  end
end
