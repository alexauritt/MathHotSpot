class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title
      t.integer :subject_id
      t.timestamps
    end
    
    add_column :lessons, :category_id, :integer    
  end

  def self.down
    remove_column :lessons, :category_id
    drop_table :categories
  end
end