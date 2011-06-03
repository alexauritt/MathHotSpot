class MathProblem < ActiveRecord::Base
  include MathHotSpotErrors
  
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :problem_level
  has_one :problem_type, :through => :problem_level
  
  before_validation :strip_excess_tags, :replace_xmlns_with_display_block
  
  DEFAULT_INSTRUCTION = Instruction.new(:description => MathHotSpotErrors::Message::NO_INSTRUCTIONS)
  
  def self.grouped_problems
    where("problem_level_id IS NOT NULL").order("problem_level_id")
  end
  
  def self.rogue_problems
    where("problem_level_id IS NULL")
  end
  
  def self.group_by_problem_level
    groups = []
    grouped_problems.chunk {|problem| problem.problem_level }.each {|level, group| groups << group }
    groups
  end
    
  def display_mode?
    problem_level.nil? ? true : problem_level.display_mode?
  end
  
  def instruction
    problem_level.nil? ? DEFAULT_INSTRUCTION : problem_level.instruction
  end
  
  def siblings
    problem_level.nil? ? [] : problem_level.math_problems.reject {|current| current == self}
  end
  
  def find_replacement(options = {})
    available_problems = MathProblem.find_all_by_problem_level_id(self.problem_level.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
    # then problem is irreplaceable -- it's one of a kind
    raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR if (available_problems.count == 1)
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem }
    end
        
    without_original = available_problems.delete_if {|problem| problem == self}
    
    if without_original.empty?
      raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING
    end
    
    without_original[rand(without_original.size)]
  end  
  
  private
  
  def strip_excess_tags
    [question_markup, answer_markup].each do |markup|
      unless markup.nil?
        markup.gsub!(/\n/,"")
        markup.gsub!(/<\/?semantics>|<annotation.*annotation>/,"")
        markup.gsub!(/>\s*</,"><")
        markup.strip!
      end
    end
  end
  
  def replace_xmlns_with_display_block
    if question_markup 
      question_markup.gsub!(/xmlns='.+?'/,"display='block'")
    end
    if answer_markup
      answer_markup.gsub!(/xmlns='.+?'/,"display='block'")
    end
  end
     
end