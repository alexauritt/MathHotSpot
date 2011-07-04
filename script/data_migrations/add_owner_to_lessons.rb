
user = User.find_by_email("admin@rightrabbit.com")
user ||= User.create(:email => 'admin@rightrabbit.com', :password => 'password')
Lesson.all.each do |lesson|
  unless lesson.owner
    lesson.owner = user
    lesson.save
  end
end