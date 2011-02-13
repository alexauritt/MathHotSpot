class CreateMathProblems < ActiveRecord::Migration
  def self.up
    create_table :math_problems do |t|
      t.integer :lesson_id
      t.integer :instructions_id
      t.text :problem_markup
      t.integer :difficulty
      t.timestamps
    end
  end

  def self.down
    drop_table :math_problems
  end
end
