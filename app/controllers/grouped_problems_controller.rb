class GroupedProblemsController < ApplicationController
  def index
    @problem_groups = MathProblem.group_by_problem_level
  end
end
