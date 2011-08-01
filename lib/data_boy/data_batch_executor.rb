require 'find'
require 'mocha'

class DataBatchExecutor
  @message = nil
  
  def self.execute!(file_name)
    if file_name.nil?
      @message = "Please specify a file"
      return
    elsif !file_found?(file_name)
      @message = 'File not found'
    else
      @message = "Executed the file!"
    end
  end
  
  def self.message
    @message
  end
  
  private
  def self.file_found?(file_name)
    Find.find('db/data_boy') do |path|
      return true if correct_file?(path, file_name)
    end
    false
  end
  
  def self.correct_file?(path, file_name)
    File.file?(path) && (file_name == File.basename(path) || file_name == File.basename(path, ".rb"))
  end
  
end