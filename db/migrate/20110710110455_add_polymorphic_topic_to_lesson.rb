class AddPolymorphicTopicToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :topic_id, :integer
    add_column :lessons, :topic_type, :string
  end

  def self.down
    remove_column :lessons, :topic_id
    remove_column :lessons, :topic_type
  end
end
