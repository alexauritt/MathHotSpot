class RenameMathProlemTemplate < ActiveRecord::Migration
  def self.up
    rename_table :math_problems, :math_problem_templates
  end

  def self.down
    rename_table :math_problem_templates, :math_problems
  end
end
