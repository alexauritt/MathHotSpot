module ApplicationHelper
  def display_difficulty(level)
    level.difficulty? ? "Difficulty: #{level.difficulty}" : MathHotSpotErrors::Message::NO_DIFFICULTY_LEVEL
  end
end