class MathYamlBuilder

  def initialize(args = nil)
    @problem_type_title = args[:problem_type_title]
    @problem_level_number = args[:problem_level_number]
    @values_list = args[:values_list]
    @question_template = args[:question_template]
    @answer_template = args[:answer_template]
    
    @values_list.extend Shuffleable
    @values_list.shuffle!
  end
  
  def build!    
    # open target yml file
    checker = MathMaker::ProblemExistenceChecker.new(@problem_type_title, @problem_level_number)
    if checker.problem_type_and_level_in_db?

      file_name += ".yml"
      target_filename = Rails.root.to_s + "/tmp/content_generation/#{filename}" 

      type = checker.problem_type
      level = ProblemLevel.find_by_problem_type_id_and_level_number(type.id, checker.level_number)

      problem_info = {
        :problem_level_id => level.id, 
        :markup_templates => {
          :question => @question_template,
          :answer => @answer_template
        }
      }

      begin
        target = File.open(target_filename, 'w')
        @values_list.each do |value_group|
          data = problem_info.merge({:values => value_group})
          yml_data = MathProblemYamlTextCreator.problem_yaml_text(data)
          target.puts yml_data
        end
        target.close
      rescue  
        puts "unable to write yml file full of math problems"
      end
    end
  end

  private
  def file_name
    "#{@problem_type_title}_level_#{@problem_level_number}".gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '_')    
  end
end
