class AddOwnerToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :owner_id, :integer
  end

  def self.down
    remove_column :lessons, :owner_id
  end
end
