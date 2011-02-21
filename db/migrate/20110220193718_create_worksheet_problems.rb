class CreateWorksheetProblems < ActiveRecord::Migration
  def self.up

    drop_table :math_problems_worksheets
    
    create_table :worksheet_problems do |t|
      t.integer :worksheet_id
      t.integer :math_problem_id
      t.integer :problem_number
      t.timestamps
    end
  end

  def self.down
    drop_table :worksheet_problems
    
    create_table :math_problems_worksheets, :id => false do |t|
      t.integer :math_problem_id
      t.integer :worksheet_id
      t.timestamps
    end
    
  end
end
