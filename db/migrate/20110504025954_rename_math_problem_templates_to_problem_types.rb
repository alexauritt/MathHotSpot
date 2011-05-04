class RenameMathProblemTemplatesToProblemTypes < ActiveRecord::Migration
  def self.up
    rename_table :math_problem_templates, :problem_types
    rename_column :problem_levels, :math_problem_template_id, :problem_type_id
  end

  def self.down
    rename_column :problem_levels, :problem_type_id, :math_problem_template_id
    rename_table :problem_types, :math_problem_templates
  end
end
