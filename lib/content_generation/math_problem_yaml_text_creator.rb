class MathProblemYamlTextCreator  
  def self.problem_yaml_text(problem_info_hash)
    unless valid_hash? problem_info_hash
      raise ArgumentError
    end
    start_and_prob_level = "-\n  problem_level_id: #{problem_info_hash[:problem_level_id]}\n"
    markups = ""
    
    
    raise(ArgumentError, "If you're going to specify an array of Template options, each such array must have same number of (corresponding) options.") unless templates_with_multiple_choices_have_same_number?(problem_info_hash[:markup_templates])
 
    problem_info_hash[:markup_templates].keys.each do |key|
      current_value = problem_info_hash[:markup_templates][key]
      raw_markup = (current_value.is_a? Array) ? current_value[rand(current_value.length)].clone : current_value.clone
      problem_info_hash[:values].each_pair do |key,value|
      raw_markup.gsub!("@#{key}", "#{value}")
    end
    
    markups.concat("  #{key.to_s.concat('_markup')}: #{raw_markup}\n")
    
   end
    start_and_prob_level.concat(markups).concat("\n")
  end
  
  private
  
  def self.templates_with_multiple_choices_have_same_number?(templates)
    choices_count = []
    templates.keys.each do |key|
      if templates[key].is_a? Array
        choices_count << templates[key].length
      end
    end
    choices_count.uniq!
    (choices_count.length == 1) || (choices_count.empty?)
  end
  
  def self.valid_hash?(hash)
    answer = true
    hash[:values].keys.each do |key|
      hash[:values].keys.each do |cur_key|
        key_str = key.to_s
        cur_key_str = cur_key.to_s
        if (key_str != cur_key_str) && (cur_key_str.include?(key_str) || (key_str.include?(cur_key_str)))
          answer = false
        end
      end
    end
    answer
  end
  
end