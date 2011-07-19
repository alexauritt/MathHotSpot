require 'pg'

begin
  conn = PGconn.connect(:dbname => 'mathpick_development', :user => 'alexauritt', :password => 'foobar')
  puts "Connected to {conn.db}"
  res = conn.exec("select * from lessons_problem_types;")
  original_count = res.count
  initial_entry_count = CoreLessonProblemType.count
  puts "#{original_count} entries from original join table"
  transfer_count = 0
  res.each do |line|
    result = CoreLessonProblemType.create(line)
    transfer_count += (result.valid? ? 1 : 0)
  end
  
  if (original_count == transfer_count) && (initial_entry_count == 0)
    puts "Clean transfer. Target table intially empty, and all records transfered successfully"
  else
    puts "Target table began with #{initial_entry_count} records"
    puts "#{original_count - transfer_count} records dropped in transfer"
  end 
rescue PGError=>e
  puts "ICKY!", e
ensure
  conn.close unless conn.nil?
  puts "Connection Closed"
end