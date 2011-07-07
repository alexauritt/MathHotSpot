# assigns Categories to existing ProblemTypes in database. 
#If no category can be found (through lesson), prints msg. 
#the goal here is to ensure that all existing ProblemTypes
# obey model constraint forcing PTs to belong to Category

ProblemType.all.each do |pt|
  begin
    pt.category ||= pt.lesson.category
    unless pt.save
      puts "ERROR: Unable to save category for the following ProblemType: #{pt}"
    end
  rescue
    puts "ERROR: Trouble find and/or saving category for the following ProblemType: #{pt}"
  end
end 