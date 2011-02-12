class WorksheetsController < ApplicationController
  def index
    render :template => "worksheets/index.xhtml.erb", :content_type => 'application/xhtml+xml'
  end
end
