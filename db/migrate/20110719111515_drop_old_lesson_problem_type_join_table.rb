class DropOldLessonProblemTypeJoinTable < ActiveRecord::Migration
  def self.up
    drop_table :lessons_problem_types
  end
  def self.down
    create_table :lessons_problem_types, :id => false do |t|
      t.integer :lesson_id, :null => false
      t.integer :problem_type_id, :null => false
    end
  end
end
