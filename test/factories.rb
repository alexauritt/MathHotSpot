# This will guess the User class

Factory.define :user do |u|
  u.email 'jim@jimbo.com'
  u.password  'secret'
end

Factory.define :user_with_lesson, :parent => :user do |user|
  user.after_create { |u| Factory(:lesson, :owner => u) }
end

Factory.define :subject do |s|
  s.title "Algebra"
end

Factory.define :category do |c|
  c.title "Polynomials"
  c.subject {|s| s.association(:subject) }
end

Factory.define :lesson do |l|
  l.title "Triangle Area Lesson"
  # l.owner { |o| o.association(:user) }
end

Factory.define :problem_type do |pt|
  pt.title "Polynomial Fraction Division"
  pt.permalink "polynomial-fraction-division"
  pt.category {|c| c.association(:category) }
  pt.owner { |o| o.association(:user) }
end

Factory.define :problem_level do |pl|
  pl.level_number "1"
  pl.problem_type { |pt| pt.association(:problem_type) }
end

Factory.define :math_problem do |mp|
  mp.question_markup 'this is markup for question'
  mp.answer_markup 'this is markup for answer'
  mp.owner { |o| o.association(:user) }
  mp.problem_level { |pl| pl.association(:problem_level) }
end

Factory.define :core_lesson_problem_type do |c|
  c.lesson { |l| l.association(:lesson) }
  c.problem_type { |pt| pt.association(:problem_type) }  
end

Factory.define :worksheet do |w|
  w.title "Algebra Review Worksheet"
  w.owner { |o| o.association(:user) }
end

Factory.define :worksheet_problem do |wp|
  wp.problem_number 1
  wp.math_problem { |mp| mp.association(:math_problem) }
  wp.worksheet { |w| w.association(:worksheet)}
end

Factory.define :tag do |t|
  t.name "Basic Addition"
end