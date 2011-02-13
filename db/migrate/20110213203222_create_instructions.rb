class CreateInstructions < ActiveRecord::Migration
  def self.up
    create_table :instructions do |t|
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :instructions
  end
end
