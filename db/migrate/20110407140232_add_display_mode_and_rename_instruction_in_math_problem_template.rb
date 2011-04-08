class AddDisplayModeAndRenameInstructionInMathProblemTemplate < ActiveRecord::Migration
  def self.up
    add_column :math_problem_templates, :display_mode, :boolean, :default => true
    rename_column :math_problem_templates, :instructions_id, :instruction_id
  end

  def self.down
    rename_column :math_problem_templates, :instruction_id, :instructions_id
    remove_column :math_problem_templates, :display_mode
  end
end
