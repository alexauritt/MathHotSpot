class AddTitleAndPermalinkToProblemType < ActiveRecord::Migration
  def self.up
    add_column :problem_types, :title, :string
    add_column :problem_types, :permalink, :string
  end

  def self.down
    remove_column :problem_types, :permalink
    remove_column :problem_types, :title
  end
end
