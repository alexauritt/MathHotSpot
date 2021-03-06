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
  
  def display_current_asset(asset)
    if asset.is_a? Lesson
      render :partial => "lessons/current_lesson_sidebar", :locals => { :current_lesson => asset }
    elsif asset.is_a? Worksheet
      render :partial => "worksheets/current_worksheet_sidebar", :locals => { :current_worksheet => asset }
    end  
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
  
  def latex_generator_popup_url
    "http://latex.codecogs.com/editor3.js"    
  end

  def equation_editor_link(text, target_id)
    link_to text, "javascript:OpenLatexEditor('#{target_id}','latex','')"
  end
        
  def problem_count_msg(problem_type)
    count = problem_type.problem_count
    count == 1 ? "1 Problem" : "#{count} Problems"
  end 
end