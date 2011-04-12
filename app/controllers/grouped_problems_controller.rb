class GroupedProblemsController < ApplicationController
  def index
    @problem_groups = MathProblem.group_all_by_template
  end
end
