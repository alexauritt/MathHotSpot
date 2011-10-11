class RenameProblemNumberToPosition < ActiveRecord::Migration
  def up
    rename_column :worksheet_problems, :problem_number, :position
  end

  def down
    rename_column :worksheet_problems, :position, :problem_number
  end
end
