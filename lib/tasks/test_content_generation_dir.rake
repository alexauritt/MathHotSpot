namespace :test do

  desc "Test Content Generation source"
  Rake::TestTask.new(:content) do |t|    
    t.pattern = 'test/lib/content_generation/*_test.rb'
    t.verbose = true    
  end
  
  desc "Test lib"
  Rake::TestTask.new(:lib) do |t|    
    t.pattern = 'test/lib/*/*_test.rb'
    t.verbose = true    
  end
  
end
