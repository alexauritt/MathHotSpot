class SimplyEquationsWithOneVariableAndAdditionLevel01 < DataBoy::DataBatchSpecification
  @model = 'MathProblem'
  def self.up
    puts "Model is #{@model}"
  end
end