class AddOwnerToWorksheet < ActiveRecord::Migration
  def self.up
    add_column :worksheets, :owner_id, :integer
  end

  def self.down
    remove_column :worksheets, :owner_id
  end
end
