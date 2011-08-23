class ProblemTypeWorksheetBuilder
  include ActiveModel::Validations
  include ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :problem_levels
  
  def persisted?
    false
  end
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end