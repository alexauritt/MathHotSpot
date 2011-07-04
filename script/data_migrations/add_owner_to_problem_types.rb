
user = User.find_by_email("admin@rightrabbit.com")
user ||= User.create(:email => 'admin@rightrabbit.com', :password => 'password')
ProblemType.all.each do |pt|
  unless pt.owner
    pt.owner = user
    pt.save
  end
end