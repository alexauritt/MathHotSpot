require 'find'
require 'mocha'

class DataBatchExecutor

  attr_accessor :message
  
  def initialize
    @message = nil
  end
  
  def execute!(file_name)
    if file_name.nil?
      @message = "Please specify a file"
      return
    else
      location = file_location(file_name)
      if location
        @message = "File was found!"
        require "gramps.rb"
      else
        @message = "File not found"
      end
    end
  end
  
  private
  def file_location(file_name)
    @path = nil
    Find.find('db/data_boy') do |path|
      if correct_file?(path, file_name)
        @path = path
        next
      end
    end
    @path
  end
    
  def correct_file?(path, file_name)
    File.file?(path) && (file_name == File.basename(path) || file_name == File.basename(path, ".rb"))
  end
  
end