module MathProblemsHelper
  def display_mathml(math_problem)
    start_tag, end_tag = math_problem.display_mode? ? ["<math mode='display'>","</math>"] : ["<p class='inline_math'>","</p>"]
    start_tag.concat(math_problem.question_markup).concat(end_tag).html_safe
  end
end
