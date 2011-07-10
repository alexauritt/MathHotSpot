class RemoveSubjectAndCategoryIdsFromLesson < ActiveRecord::Migration
  def self.up
    remove_column :lessons, :category_id
    remove_column :lessons, :subject_id
  end

  def self.down
    add_column :lessons, :category_id, :integer
    add_column :lessons, :subject_id, :integer    
  end
end
