class AvailableTagsController < ApplicationController
  def index
    render :json => Tag.all.map {|t| t.name}
  end
  
  def search
    render :json => Tag.where("lower(name) ILIKE ?", "#{params[:term]}%").map {|t| t.name}
  end
end
