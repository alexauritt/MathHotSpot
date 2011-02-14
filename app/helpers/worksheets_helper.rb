module WorksheetsHelper
  def display_mathml(math_problem_template)
    math_problem_template.problem_markup.html_safe
  end
end
