class MathProblemYamlTextCreator  
  def self.problem_yaml_text(problem_info_hash)
    unless valid_hash? problem_info_hash
      raise ArgumentError
    end
    start_and_prob_level = "-\n  problem_level_id: #{problem_info_hash[:problem_level_id]}\n"

    markups = ""
    problem_info_hash[:markup_templates].keys.each do |key|
      raw_markup = problem_info_hash[:markup_templates][key]
      problem_info_hash[:values].each_pair do |key,value|
        raw_markup.gsub!("@#{key}", "#{value}")
      end
      markups.concat("  #{key.to_s.concat('_markup')}: #{raw_markup}\n")
    end
    start_and_prob_level.concat(markups).concat("\n")
  end
  
  private
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