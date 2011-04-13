module LessonsHelper
  def title(lesson)
    lesson.subject.title + ": " + lesson.title
  end
end
