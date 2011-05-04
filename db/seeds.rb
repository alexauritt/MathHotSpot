# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

subjects = Subject.create([{ :title => "Algebra I"}, { :title => "Geometry"}, { :title => "Algebra II" }, { :title => "Precalculus" }, { :title => "Calculus"} ])

lessons = Lesson.create([{ :title => 'Dividing Monomials', :chapter => 5, :section => 2, :subject_id => subjects.first.id }])

instructions = Instruction.create([
  { :description => "Simplify" }, 
  { :description => "Find the GCF of each pair of monomials" },
  { :description => "Simplify. Assume that no denominator equals 0." }
])

problem_types = ProblemType.create([
  { :lesson_id => lessons.first, :instruction => instructions.first},
  { :lesson_id => lessons.first, :instruction => instructions[1], :display_mode => false },
  { :lesson_id => lessons.first, :instruction => instructions[2] }
])

problem_levels = ProblemLevel.create([
  { :problem_type => problem_types[0], :difficulty => 1 },
  { :problem_type => problem_types[0], :difficulty => 2 },
  { :problem_type => problem_types[0], :difficulty => 3 },
  { :problem_type => problem_types[0], :difficulty => 4 },
  { :problem_type => problem_types[0], :difficulty => 5 },
  { :problem_type => problem_types[0], :difficulty => 6 },

  { :problem_type => problem_types[1], :difficulty => 3},
  { :problem_type => problem_types[2], :difficulty => 3},  
])

MathProblem.create([
  { :problem_level => problem_levels[0], 
  :question_markup => '<math display="block"><mfrac><mrow><mn>-4</mn><mi>x</mi><mi>y</mi></mrow><mrow><mn>10</mn><mi>x</mi></mrow></mfrac></math>'},
  
  { :problem_level => problem_levels[0], 
  :question_markup => '<math display="block"><mfrac><mrow><mn>-2</mn><mi>a</mi><mi>b</mi></mrow><mrow><mn>14</mn><mi>a</mi></mrow></mfrac></math>'},    

  { :problem_level => problem_levels[1], 
  :question_markup => '<math display="block"><mfrac><mrow><msup><mi>c</mi><mn>7</mn></msup></mrow><mrow><msup><mi>c</mi><mn>4</mn></msup></mrow></mfrac></math>'},

  { :problem_level => problem_levels[1], 
  :question_markup => '<math display="block"><mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac></math>'},

  { :problem_level => problem_levels[1], 
  :question_markup => '<math display="block"><mfrac><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow></mfrac></math>'},

#6
  { :problem_level => problem_levels[2], 
  :question_markup => '<math display="block"><mfrac><mrow><mn>12</mn><msup><mi>x</mi><mn>5</mn></msup></mrow><mrow><mn>-3</mn><msup><mi>x</mi><mn>3</mn></msup></mrow></mfrac></math>'},

  { :problem_level => problem_levels[2],
  :question_markup => '<math display="block"><mfrac><mrow><mn>-5</mn><msup><mi>k</mi><mn>4</mn></msup></mrow><mrow><mn>20</mn><mi>k</mi></mrow></mfrac></math>'},

#8
  { :problem_level => problem_levels[3],
  :question_markup => '<math display="block"><mfrac><mrow><mi>m</mi><msup><mi>n</mi><mn>5</mn></msup></mrow><mrow><msup><mi>m</mi><mn>3</mn></msup><msup><mi>n</mi><mn>2</mn></msup></mrow></mfrac></math>'},

  { :problem_level => problem_levels[3],
  :question_markup => '<math display="block"><mfrac><mrow><msup><mi>x</mi><mn>5</mn></msup><msup><mi>y</mi><mn>4</mn></msup></mrow><mrow><mi>x</mi><msup><mi>y</mi><mn>10</mn></msup></mrow></mfrac></math>'},

#10
  { :problem_level => problem_levels[4],
  :question_markup => '<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>5</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>'},

  { :problem_level => problem_levels[4],
  :question_markup => '<math display="block"><mfrac><mrow><msup><mfenced><mrow><mn>3</mn><mi>x</mi></mrow></mfenced><mn>2</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>x</mi></mrow></mfenced><mn>4</mn></msup></mrow></mfrac></math>'},

#12
  { :problem_level => problem_levels[5],
  :question_markup => '<math display="block"><mfrac><mrow><mo>-</mo><mfenced><mrow><msup><mi>m</mi><mn>3</mn></msup><mi>n</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>m</mi><mi>n</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac></math>'},
  
  { :problem_level => problem_levels[5],
  :question_markup => '<math display="block"><mfrac><mrow><msup><mfenced><mi>-x</mi></mfenced><mn>2</mn></msup><mi>y</mi></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>x</mi><mi>y</mi></mrow></mfenced><mn>5</mn></msup></mrow></mfrac></math>'},

#14  
  { :problem_level => problem_levels[6],
  :question_markup => '<math><mrow><mn>72</mn><msup><mi>x</mi><mn>3</mn></msup><mi>y</mi><msup><mi>z</mi><mn>3</mn></msup></mrow></math><span class="problem_type">and</span><math><mrow><mn>120</mn><msup><mi>x</mi><mn>2</mn></msup><msup><mi>z</mi><mn>5</mn></msup></mrow></math>'},

  { :problem_level => problem_levels[6],
  :question_markup => '<math><mrow><mn>4</mn><msup><mi>p</mi><mn>2</mn></msup><mfenced><mrow><mi>p</mi><mo>-</mo><mn>1</mn></mrow></mfenced></mrow></math><span class="math_text">and</span><math><mrow><mn>6</mn><mi>p</mi><msup><mfenced><mrow><mi>p</mi><mo>+</mo><mn>1</mn></mrow></mfenced><mn>2</mn></msup></mrow></math>'},

#16
  { :problem_level => problem_levels[7],
  :question_markup => '<math display="block"><mfrac><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>3</mn></msup></mrow><mrow><msup><mfenced><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>'},
  
  { :problem_level => problem_levels[7],
  :question_markup => '<math display="block"><mfrac><mrow><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mfenced><mrow><mi>x</mi><mo>-</mo><mi>y</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mi>x</mi><mo>+</mo><mi>y</mi></mrow></mfenced><mn>2</mn></msup></mrow></mfrac></math>'}
])

worksheet = Worksheet.create(:title => "My first worksheet")
problems_for_worksheet = MathProblem.find(1,2,3,4,6,8,10,12,14,15,16,17)
problems_for_worksheet.each_with_index do |p, index|
  worksheet.worksheet_problems << WorksheetProblem.new({:math_problem_id => p.id, :problem_number => index + 1 })
end

worksheet.save