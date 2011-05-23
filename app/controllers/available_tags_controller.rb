class AvailableTagsController < ApplicationController
  def index
    render :json => Tag.all.map {|t| t.name}
  end
end
