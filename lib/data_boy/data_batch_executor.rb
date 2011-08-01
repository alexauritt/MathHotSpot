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
    elsif !file_found?(file_name)
      @message = 'File not found'
    else
      @message = "Executed the file!"
    end
  end
  
  private
  def file_found?(file_name)
    @found = false
    Find.find('db/data_boy') do |path|
      if correct_file?(path, file_name)
        @found = true 
        next
      end
    end
    @found
  end
  
  def correct_file?(path, file_name)
    File.file?(path) && (file_name == File.basename(path) || file_name == File.basename(path, ".rb"))
  end
  
end