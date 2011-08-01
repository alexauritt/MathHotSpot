namespace :test do

  desc "Test Content Generation source"
  Rake::TestTask.new(:content_generation) do |t|    
    t.pattern = 'test/lib/content_generation/*_test.rb'
    t.verbose = true    
  end
  
  desc "Test Databoy"
  Rake::TestTask.new(:databoy) do |t|
    t.pattern = 'test/lib/content_generation/data_boy/*_test.rb'
    t.verbose = true        
  end
  
  desc "Test lib"
  task :lib => [:content_generation, :databoy] do
  end
  
end
