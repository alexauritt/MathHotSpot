class RenameProblemLevelDifficultyToLevelNumber < ActiveRecord::Migration
  def self.up
    rename_column :problem_levels, :difficulty, :level_number
  end

  def self.down
    rename_column :problem_levels, :level_number, :difficulty
  end
end
