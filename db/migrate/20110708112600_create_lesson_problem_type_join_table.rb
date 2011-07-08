class CreateLessonProblemTypeJoinTable < ActiveRecord::Migration
  def self.up
    create_table :lessons_problem_types, :id => false do |t|
      t.integer :lesson_id, :null => false
      t.integer :problem_type_id, :null => false
    end
  end

  def self.down
    drop_table :lessons_problem_types
  end
end
