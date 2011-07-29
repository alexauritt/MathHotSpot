namespace :check_live do
  desc "check audrey's account"
  task :auds do
    puts `heroku console --app rightrabbit 'User.find 3'`
  end
end