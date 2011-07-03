class AddOwnerIdToProblemType < ActiveRecord::Migration
  def self.up
    add_column :problem_types, :owner_id, :integer
  end

  def self.down
    remove_column :problem_types, :owner_id
  end
end
