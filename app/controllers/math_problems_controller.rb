class MathProblemsController < ApplicationController
  def index
    @math_problems = MathProblem.all
    render :template => "math_problems/index.xhtml.erb", :layout => "application.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end