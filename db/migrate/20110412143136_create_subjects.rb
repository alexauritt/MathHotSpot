class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :title
      t.timestamps
    end
    add_column :lessons, :subject_id, :integer
  end

  def self.down
    remove_column :lessons, :subject_id
    drop_table :subjects
  end
end
