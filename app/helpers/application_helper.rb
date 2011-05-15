module ApplicationHelper
  def display_difficulty(level)
    level.difficulty? ? "Difficulty: #{level.difficulty}" : MathHotSpotErrors::Message::NO_DIFFICULTY_LEVEL
  end
  
  def include_mathjax
    ::Rails.env == "production" ? cdn_mathjax_link : local_mathjax_link
  end
  
  def cdn_mathjax_link
    javascript_include_tag('http://cdn.mathjax.org/mathjax/1.1-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML')
  end
  
  def local_mathjax_link
    javascript_include_tag("math_jax/MathJax.js?config=TeX-AMS-MML_HTMLorMML,local/local")
  end
end