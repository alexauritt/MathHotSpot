class CreateProblemLevels < ActiveRecord::Migration
  def self.up
    remove_column :math_problem_templates, :difficulty

    create_table :problem_levels do |t|
      t.integer :math_problem_template_id
      t.integer :difficulty
      t.timestamps
    end
    
    rename_column :math_problems, :math_problem_template_id, :problem_level_id
  end

  def self.down
    rename_column :math_problems, :problem_level_id, :math_problem_template_id
    
    drop_table :problem_levels
    
    add_column :math_problem_templates, :difficulty, :integer
  end
end
