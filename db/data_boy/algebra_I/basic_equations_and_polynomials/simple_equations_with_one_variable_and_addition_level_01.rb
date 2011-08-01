class SimplyEquationsWithOneVariableAndAdditionLevel01 < DataBoy::DataBatchSpecification

  # x + 0 = 0, x + 1 = 1 .... x + 8 = 9

  def self.up
    @model = 'MathProblem'
    @problem_type_title = "Simple Equations: One Variable, Addition"
    @problem_level_number = 1
    @question_template = '\[x + @left = @right\]'
    @answer_template = '\[x = @solution\]'
  end
  
  def self.data
    values_list = []
    10.times do |left_val|
      Array(left_val .. 9).each do |right_val|
        values_list << {left: left_val, right: right_val, solution: right_val - left_val }
      end
    end
    values_list
  end
end