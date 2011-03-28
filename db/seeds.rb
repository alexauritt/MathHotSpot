# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


lessons = Lesson.create([{ :title => 'Diving Monomials', :chapter => 5, :section => 2}])

instructions = Instructions.create([{ :description => "Simplify"}])

problem_templates = MathProblemTemplate.create([
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 1 },
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 2 },
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 3 },
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 4 },
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 5 },
  { :lesson_id => lessons.first, :instructions_id => instructions.first, :difficulty => 6 }    
])

MathProblem.create([
    { :math_problem_template => problem_templates[0],
    :problem_markup => '<mfrac><mrow><mn>-4</mn><mi>x</mi><mi>y</mi></mrow><mrow><mn>10</mn><mi>x</mi></mrow></mfrac>'},
    
    { :math_problem_template => problem_templates[0],
    :problem_markup => '<mfrac><mrow><mn>-2</mn><mi>a</mi><mi>b</mi></mrow><mrow><mn>14</mn><mi>a</mi></mrow></mfrac>'},    


    { :math_problem_template => problem_templates[1],
    :problem_markup => '<mfrac><mrow><msup><mi>c</mi><mn>7</mn></msup></mrow><mrow><msup><mi>c</mi><mn>4</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[1],
    :problem_markup => '<mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[1],
    :problem_markup => '<mfrac><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow><mrow><msup><mi>b</mi><mn>5</mn></msup></mrow></mfrac>'},


    { :math_problem_template => problem_templates[2],
    :problem_markup => '<mfrac><mrow><mn>12</mn><msup><mi>x</mi><mn>5</mn></msup></mrow><mrow><mn>-3</mn><msup><mi>x</mi><mn>3</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[2],
    :problem_markup => '<mfrac><mrow><mn>-5</mn><msup><mi>k</mi><mn>4</mn></msup></mrow><mrow><mn>20</mn><mi>k</mi></mrow></mfrac>'},


    { :math_problem_template => problem_templates[3],
    :problem_markup => '<mfrac><mrow><mi>m</mi><msup><mi>n</mi><mn>5</mn></msup></mrow><mrow><msup><mi>m</mi><mn>3</mn></msup><msup><mi>n</mi><mn>2</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[3],
    :problem_markup => '<mfrac><mrow><msup><mi>x</mi><mn>5</mn></msup><msup><mi>y</mi><mn>4</mn></msup></mrow><mrow><mi>x</mi><msup><mi>y</mi><mn>10</mn></msup></mrow></mfrac>'},


    { :math_problem_template => problem_templates[4],
    :problem_markup => '<mfrac><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>5</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>k</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[4],
    :problem_markup => '<mfrac><mrow><msup><mfenced><mrow><mn>3</mn><mi>x</mi></mrow></mfenced><mn>2</mn></msup></mrow><mrow><msup><mfenced><mrow><mn>2</mn><mi>x</mi></mrow></mfenced><mn>4</mn></msup></mrow></mfrac>'},


    { :math_problem_template => problem_templates[5],
    :problem_markup => '<mfrac><mrow><mo>-</mo><mfenced><mrow><msup><mi>m</mi><mn>3</mn></msup><mi>n</mi></mrow></mfenced></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>m</mi><mi>n</mi></mrow></mfenced><mn>3</mn></msup></mrow></mfrac>'},

    { :math_problem_template => problem_templates[5],
    :problem_markup => '<mfrac><mrow><msup><mfenced><mi>-x</mi></mfenced><mn>2</mn></msup><mi>y</mi></mrow><mrow><msup><mfenced><mrow><mo>-</mo><mi>x</mi><mi>y</mi></mrow></mfenced><mn>5</mn></msup></mrow></mfrac>'}							

])

worksheet = Worksheet.create(:title => "My first worksheet")
problems_for_worksheet = MathProblem.find(1,2,3,4,6,8,10,12)
problems_for_worksheet.each_with_index do |p, index|
  worksheet.worksheet_problems << WorksheetProblem.new({:math_problem_id => p.id, :problem_number => index + 1 })
end

worksheet.save