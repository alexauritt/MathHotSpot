class WorksheetBuilder

  def initialize  
  end
  
  def build(params)
    @current_worksheet = Worksheet.new
    @problems_to_add = []
    begin
      params.each_pair do |key, value|
        key.to_s == "problem_levels_info" ? find_problems_from_specs_for_current_worksheet!(value) : @current_worksheet.send("#{key}=",value)
      end
    rescue
    end
    @current_worksheet.worksheet_problems_attributes = nested_worksheet_problem_parameters
    @current_worksheet
  end
  
  private
  def find_problems_from_specs_for_current_worksheet!(value_params)
    problems = []
    value_params.each_pair do |level_id, count|
      problems << MathProblem.all(:limit => count.to_i, :conditions => {:problem_level_id => level_id.to_i})
    end
    @problems_to_add = problems.flatten
  end
  
  def nested_worksheet_problem_parameters
    params = Hash.new
    @problems_to_add.each do |prob|
      index = params.size
      params[index.to_s] = {:math_problem_id => prob.id, :problem_number => index + 1}
    end
    params
  end
end