class WorksheetsController < ApplicationController
  def index
    @math_problems = MathProblem.all
    render :template => "worksheets/index.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
