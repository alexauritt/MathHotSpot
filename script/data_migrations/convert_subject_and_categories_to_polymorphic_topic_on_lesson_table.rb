require 'pg'

begin
  conn = PGconn.connect(:dbname => 'mathpick_development', :user => 'alexauritt', :password => 'foobar')
  puts "Connected to {conn.db}"
  res = conn.exec("UPDATE lessons SET topic_id = category_id, topic_type = 'Category' WHERE category_id IS NOT NULL;")
  res.each do |line|
    puts "Result of Category conversions is #{line}"
  end
  res = conn.exec("UPDATE lessons SET topic_id = subject_id, topic_type = 'Subject' WHERE category_id IS NULL AND subject_id IS NOT NULL;")
  res.each do |line|
    puts "Result of Subject conversions is #{line}"
  end
rescue PGError=>e
  puts "ICKY!", e
ensure
  conn.close unless conn.nil?
  puts "Connection Closed"
end




