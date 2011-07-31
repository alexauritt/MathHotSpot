PATH = "tmp/content_generation/"

class MathProblemYamlReader
  def load(file)
    location = PATH + file + ".yml"
    @file = File.open(location) if File.exists?(location)
    @file.nil? ? false : true
  end
  
  def is_file_valid?
    true
  end
  
  def create!
    puts "I am creating"
  end
end