class MathProblem < ActiveRecord::Base
  include MathHotSpotErrors
  include RightRabbitErrors
  
  has_many :worksheet_problems, :dependent => :destroy
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :problem_level
  has_one :problem_type, :through => :problem_level
  belongs_to :owner, :class_name => "User"

  validates_presence_of :question_markup, :answer_markup, :owner_id
  validates :question_markup, :uniqueness => {:scope => :problem_level_id}
  validate :problem_level_exists, :owner_exists

  before_validation :strip_excess_tags, :replace_xmlns_with_display_block
  
  
  DEFAULT_INSTRUCTION = Instruction.new(:description => MathHotSpotErrors::Message::NO_INSTRUCTIONS)
      
  def self.group_by_problem_level
    groups = []
    MathProblem.all.chunk {|problem| problem.problem_level }.each {|level, group| groups << group }
    groups
  end
    
  def display_mode?
    problem_level.nil? ? true : problem_level.display_mode?
  end
  
  def instruction
    problem_level.nil? ? DEFAULT_INSTRUCTION : problem_level.instruction
  end

  def instruction_description
    instruction.description
  end
  
  def siblings(max_count = nil)
    all_siblings = problem_level.nil? ? [] : problem_level.math_problems.reject {|current| current == self}
    requested_sibs = max_count == nil ? all_siblings : all_siblings.first(max_count)
  end
  
  def sibling_available?(options = {})
    begin
      available_problems = find_problem_from_same_level options
      true
    rescue
      false
    end
  end
  
  def find_problem_from_same_level(options = {})
    available_problems = MathProblem.find_all_by_problem_level_id(self.problem_level.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
    # then problem is irreplaceable -- it's one of a kind
    raise UniqueProblemError if (available_problems.count == 1)
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem }
    end
        
    without_original = available_problems.delete_if {|problem| problem == self}
    
    if without_original.empty?
      raise NoSimilarProblemsRemainingError
    end
    
    without_original[rand(without_original.size)]
  end  
  
  private

  def owner_exists
    if owner_id
      errors.add(:owner_id, "doesn't exist in database") unless User.exists?(owner_id)
    end
  end
  
  def problem_level_exists
    begin
      errors.add(:problem_level_id, "doesn't exist") unless (!problem_level.nil? || (problem_level_id && ProblemLevel.exists?(problem_level_id)))
    rescue
      errors.add(:problem_level_id, "not found in db")
    end
  end
  
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