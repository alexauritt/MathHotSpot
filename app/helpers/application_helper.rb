module ApplicationHelper

  def user_login_or_logout_link
    user_signed_in? ? link_to("Sign Out", destroy_user_session_url, :method => :delete) : link_to("Sign In", new_user_session_url)
  end
  
  def display_email_if_signed_in
    user_signed_in? ? current_user.email.concat(" | ") : ""
  end
  
  def display_level_number(level)
    level.level_number? ? "Level: #{level.level_number}" : MathHotSpotErrors::Message::NO_LEVEL_NUMBER
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

  def latex_generator_link
    link_to "Help! I need a LaTeX Generator", "http://www.codecogs.com/latex/eqneditor.php", :target => "_blank"
  end
  
  def mathml_generator_link
    link_to "Help! I need a MathML Generator", "http://www.mathmlcentral.com/Tools/ToMathML.jsp", :target => "_blank"
  end
    
  def problem_count_msg(problem_type)
    count = problem_type.problem_count
    count == 1 ? "1 Problem" : "#{count} Problems"
  end  
end