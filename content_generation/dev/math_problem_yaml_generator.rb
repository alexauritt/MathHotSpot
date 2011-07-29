class MathProblemYAMLGenerator
  attr_accessor :problem_type_name, :problem_level_number, :question_template, :answer_template

  def self.yaml_text(collection_spec)
    if collection_spec.instance_of?(MathProblemCollectionSpec) && collection_spec.valid?
      ProblemType.find_by_title(collection_spec.problem_type_title)    
    else
      nil
    end

  end
  
end