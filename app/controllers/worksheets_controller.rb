class WorksheetsController < ApplicationController
  def index
    @math_problem_templates = MathProblemTemplate.all
    render :template => "worksheets/index.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
