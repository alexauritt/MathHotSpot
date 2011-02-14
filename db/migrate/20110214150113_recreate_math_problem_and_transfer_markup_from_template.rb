class RecreateMathProblemAndTransferMarkupFromTemplate < ActiveRecord::Migration
  def self.up
    create_table :math_problems do |t|
      t.integer :math_problem_template_id
      t.text :problem_markup
      t.timestamps
    end
    
    remove_column :math_problem_templates, :problem_markup
  end

  def self.down
    add_column :math_problem_templates, :problem_markup
    drop_table :math_problems
  end
end
