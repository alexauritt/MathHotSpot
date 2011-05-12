Lesson.all.each do |lesson|
  category = Category.create(:subject => lesson.subject, :title => lesson.title)
  lesson.category = category
  lesson.save
end