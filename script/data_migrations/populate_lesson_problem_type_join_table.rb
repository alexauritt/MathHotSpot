require 'pg'

begin
  conn = PGconn.connect(:dbname => 'mathpick_development', :user => 'alexauritt', :password => 'foobar')
  puts "Connected to {conn.db}"
  res = conn.exec("insert into lessons_problem_types (lesson_id, problem_type_id) SELECT lesson_id, id AS problem_type_id FROM problem_types WHERE lesson_id IS NOT NULL;")
  res.each do |line|
    puts "res is #{line}"
  end
rescue PGError=>e
  puts "ICKY!", e
ensure
  conn.close unless conn.nil?
  puts "Connection Closed"
end