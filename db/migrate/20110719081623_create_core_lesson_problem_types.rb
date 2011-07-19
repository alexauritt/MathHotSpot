class CreateCoreLessonProblemTypes < ActiveRecord::Migration
  def self.up
    create_table :core_lesson_problem_types do |t|
      t.integer :lesson_id
      t.integer :problem_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :core_lesson_problem_types
  end
end
