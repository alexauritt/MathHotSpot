module WorksheetsHelper
  def display_math_problem(math_problem)
    math_problem.problem_markup.html_safe
  end
end
