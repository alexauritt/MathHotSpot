class DropLessonIdFromProblemType < ActiveRecord::Migration
  def self.up
    remove_column :problem_types, :lesson_id
  end

  def self.down
    add_column :problem_types, :lesson_id, :integer
  end
end
