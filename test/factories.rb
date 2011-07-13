# This will guess the User class
Factory.define :user do |u|
  u.email 'jim@jimbo.com'
  u.password  'secret'
end

Factory.define :subject do |s|
  s.title "Algebra"
end

Factory.define :category do |c|
  c.title "Polynomials"
  c.subject {|s| s.association(:subject) }
end
