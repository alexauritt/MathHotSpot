class ProblemType < ActiveRecord::Base
  include MathHotSpotErrors
  
  belongs_to :instruction
  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :core_lesson_problem_types, :dependent => :destroy
  has_many :lessons, :through => :core_lesson_problem_types
  
  has_many :problem_levels, :inverse_of => :problem_type, :order => :level_number
  has_many :math_problems, :through => :problem_levels

  acts_as_taggable

  accepts_nested_attributes_for :problem_levels, :reject_if => lambda { |level| level[:level_number].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :instruction
  
  validates_presence_of :title, :permalink, :category_id, :owner_id
  validates_uniqueness_of :title, :permalink, :case_sensitive => false
  
  validates_associated :category, :instruction, :owner

  before_validation :generate_slug, :if => :title
  
  before_destroy :empty?

  def empty?
    problem_levels.empty?
  end

  def add_tag
    nil
  end

  def add_tag=(tag)
    self.tag_list.add tag
  end

  def to_param
    permalink
  end
  
  def permalink
    permalink ||= generate_slug
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

  def topic_name
    category.name
  end
  
  def instruction_text
    instruction.nil? ? MathHotSpotErrors::Message::NO_INSTRUCTIONS : instruction.description
  end

  def self.search(search)
    raise ArgumentError unless search.is_a?(Hash)
    if tag = search[:tag] # tag button clicked, not tag query search
      ProblemType.tagged_with(tag)
    elsif query = search[:query]
      tag_query?(query) ? tag_search(query) : title_search(query)
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
  
  def self.generate_permalink_from(title)
    title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-')
  end
  
  private
  def generate_slug
    self.permalink = ProblemType.generate_permalink_from(self.title)
  end
  
  def self.format_query_string_for_tag_search(query_string)
    unesc = query_string.gsub('"','')
    tag_list = unesc.squeeze(" ").split(/,/)
    tag_list.each {|tag| tag.strip!}
    tag_list
  end

  def self.tag_query?(query)
    query.include?("\"") || query.include?("\'")
  end
  
  def self.title_search(query)
    self.where("lower(title) ILIKE ?", "%#{query}%")
  end
  
  def self.tag_search(query)
    self.tagged_with(format_query_string_for_tag_search query)    
  end
  
end
