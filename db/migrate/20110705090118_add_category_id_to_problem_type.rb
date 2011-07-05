class AddCategoryIdToProblemType < ActiveRecord::Migration
  def self.up
    add_column :problem_types, :category_id, :integer
  end

  def self.down
    remove_column :problem_types, :category_id
  end
end
