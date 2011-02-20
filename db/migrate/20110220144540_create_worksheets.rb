class CreateWorksheets < ActiveRecord::Migration
  def self.up
    create_table :worksheets do |t|
      t.timestamps
    end
        
    create_table :math_problems_worksheets do |t|
      t.integer :math_problem_id
      t.integer :worksheet_id
      t.timestamps
    end

  end

  def self.down
    drop_table :worksheets
    drop_table :math_problems_worksheets
  end
end
