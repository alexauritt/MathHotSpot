class ProblemType < ActiveRecord::Base
  include MathHotSpotErrors
  
  belongs_to :lesson
  belongs_to :instruction
  
  has_many :problem_levels, :order => :level_number, :dependent => :destroy
  has_many :math_problems, :through => :problem_levels

  acts_as_taggable

  accepts_nested_attributes_for :problem_levels
  accepts_nested_attributes_for :instruction
  
  validates_presence_of :title, :permalink
  validates_uniqueness_of :title, :permalink, :case_sensitive => false

  before_validation :generate_slug, :if => :title
  before_validation :initialize_problem_levels, :on => :create

  def new_tag
    nil
  end

  def new_tag=(tag)
    self.tag_list.add tag
  end

  def to_param
    permalink
  end
  
  def permalink
    permalink ||= generate_slug
  end

  # required if we want nested_attributes AND validation of this parent in problem_level
  def initialize_problem_levels
    problem_levels.each { |pl| pl.problem_type = self }
  end  
  
  def demo_problem
    non_empty_level = problem_levels.detect {|level| !level.empty? }
    non_empty_level.nil? ? MathHotSpotErrors::EmptyProblem : non_empty_level.demo_problem
  end

  def problem_count
    total = 0
    problem_levels.each do |level|
      total += level.math_problems.size
    end
    total
  end
  
  def level_count
    problem_levels.size
  end
  
  def lowest_available_level_number
    level_numbers = problem_levels.map {|level| level.level_number}
    level_numbers.sort!
    level_count.times do |cur|
      unless level_numbers[cur] == (cur + 1) 
        return (cur + 1)
      end
    end
    level_count + 1
  end

  def self.search(search)
    if search
      self.where("lower(title) ILIKE ?", "%#{search}%") | self.tagged_with("%#{search}%")
    else
      self.find(:all)
    end
  end
  
  def self.find_replacement(math_problem, options = {})
    available_problems = MathProblem.find_all_by_problem_type_id(math_problem.problem_type.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
      # then problem is irreplaceable -- it's one of a kind
    raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR if (available_problems.count == 1)
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem }
    end
        
    without_original = available_problems.delete_if {|problem| problem == math_problem}
    
    if without_original.empty?
      raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING
    end
    
    without_original[rand(without_original.size)]
  end
  
  def self.empty_problem
    MathHotSpotErrors::EmptyProblem
  end
  
  private
  def generate_slug
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-')
  end
  
end
