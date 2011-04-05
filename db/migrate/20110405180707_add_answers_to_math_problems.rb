class AddAnswersToMathProblems < ActiveRecord::Migration
  def self.up
    add_column :math_problems, :answer_markup, :string
    rename_column :math_problems, :problem_markup, :question_markup
  end

  def self.down
    rename_column :math_problems, :question_markup, :problem_markup
    remove_column :math_problems, :problem_markup
  end
end
