module ApplicationHelper
  def display_difficulty(level)
    level.difficulty? ? "Difficulty: #{level.difficulty}" : MathHotSpotErrors::Message::NO_DIFFICULTY_LEVEL
  end
  
  def cdn_mathjax_link
    javascript_include_tag('http://cdn.mathjax.org/mathjax/1.1-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML')
  end
end