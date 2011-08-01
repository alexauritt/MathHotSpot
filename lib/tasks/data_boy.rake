require_relative "../data_boy/data_batch_executor"

namespace :data_boy do
  desc "execute given batch specification"
  task :execute do
    DataBatchExecutor.execute!(ENV['FILE'])
    puts DataBatchExecutor.message
  end
end

def ensure_file_specified!
  unless ENV['FILE']
    puts 'Please input a data batch specification: rake databoy:execute FILE=some_file_name'
    false
  else
    true
  end
end