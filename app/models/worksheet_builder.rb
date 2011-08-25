class WorksheetBuilder
      
  def self.build(params)
    worksheet = Worksheet.new
    begin
      params.each do |key, value|
        key == "problems" ? add_problems(value) : worksheet.send("#{key}=",value)
      end
    rescue
    end
    worksheet
  end
end