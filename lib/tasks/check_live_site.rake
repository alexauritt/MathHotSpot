namespace :check_live do
  desc "check audrey's account"
  task :auds do
    puts `heroku console --app rightrabbit 'User.find 3'`
  end
  
  desc "check if live db schema is up to date"
  task :db do
    live_db_version = `heroku rake db:version --app rightrabbit | grep "Current version"`
    local_db_version = `rake db:version`
    if live_db_version == local_db_version
      "Up to date: current live production schema matches local schema"
    else
      puts "NOT UP TO DATE"
      puts "heroku is #{live_db_version}"
      puts "local is #{local_db_version}"
    end
  end
end