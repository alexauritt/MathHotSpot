class AddOwnerIdToMathProblems < ActiveRecord::Migration
  def self.up
    add_column :math_problems, :owner_id, :integer
  end

  def self.down
    remove_column :math_problems, :owner_id
  end
end
