user = User.find_by_email("alexauritt@gmail.com")
ProblemType.all.each do |pt|
  unless pt.owner
    pt.owner = user
    pt.save
  end
end