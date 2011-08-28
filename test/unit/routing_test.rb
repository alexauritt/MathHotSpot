require 'test_helper'

class RoutingTest < ActionController::TestCase


#dashboard
  test "dashboard route" do
    assert_routing( { :path => '/dashboard', :method => :get}, { :controller => 'dashboards', :action => 'show' })
  end

#instructions
  test "instructions new" do
    assert_routing( {:path => "instructions/new", :method => :get}, {:controller => "instructions", :action => "new"})
  end
  
  test "instruction create" do
    assert_routing( {:path => "instructions", :method => :post}, {:controller => "instructions", :action => "create"})    
  end
  
#lessons
  test "lesson create" do
    assert_routing( {:path => "/lessons", :method => :post}, {:controller => "lessons", :action => "create"})
  end

  test "lesson new" do
    assert_routing( {:path => "/lessons/new", :method => :get}, {:controller => "lessons", :action => "new"})
  end

  test "lesson show" do
    assert_routing( {:path => "/lessons/23", :method => :get}, {:controller => "lessons", :action => "show", :id => "23"})
  end  

  test "lesson index" do
    assert_routing( {:path => "/lessons", :method => :get}, {:controller => "lessons", :action => "index"})
  end

#mylessons
  test "my lessons route" do
    assert_routing( { :path => '/my_lessons', :method => :get}, { :controller => 'my_lessons', :action => 'index' })
  end
  
#problem_types

  test "problem_type new" do
    assert_routing( {:path => "/problem_types/new", :method => :get}, {:controller => "problem_types", :action => "new"})
  end
  
  test "problem_type index" do
    assert_routing( {:path => "/problem_types", :method => :get}, {:controller => "problem_types", :action => "index"})
  end
  
  test "problem_type_problem_level new" do
    assert_routing( {:path => "/problem_types/123/problem_levels/new", :method => :get}, {:controller => "problem_levels", :action => "new", :problem_type_id => "123"})
  end

  test "problem_type edit / update" do
    assert_routing( {:path => "problem_types/234/edit", :method => :get}, {:controller => "problem_types", :action => 'edit', :id => '234'})
    assert_routing( {:path => "problem_types/654", :method => :put}, {:controller => "problem_types", :action => 'update', :id => '654'})
  end

#problem_levels
  test "problem_level show" do
    assert_routing( {:path => "/problem_types/i-want-to-ride-my-bicycle/problem_levels/3", :method => :get},
      {:controller => "problem_levels", :action => "show", :problem_type_id => "i-want-to-ride-my-bicycle", :id => '3'})
  end

  test "problem_level create" do
    assert_routing( {:path => "/problem_levels", :method => :post}, 
      {:controller => "problem_levels", :action => "create"})
  end

  test "problem_level update" do
    assert_routing( {:path => '/problem_types/a-prob-type/problem_levels/4', :method => :put},
      {:controller => "problem_levels", :action => "update", :problem_type_id => 'a-prob-type', :id => '4'})
  end

  test "problem_level delete" do
    assert_routing( {:path => "/problem_types/some-prob-type/problem_levels/8", :method => :delete}, 
      {:controller => "problem_levels", :action => "destroy", :problem_type_id => 'some-prob-type', :id => '8'})
  end
  
#math_problems
  test "problem_level_math_problem new" do
    assert_routing( {:path => "/problem_types/cool-problem/problem_levels/4/math_problems/new", :method => :get}, 
      {:controller => "math_problems", :action => "new", :problem_level_id => "4", :problem_type_id => 'cool-problem'})    
  end

  test "show category" do
    assert_routing( {:path => "/categories/3", :method => :get}, {:controller => 'categories', :action => 'show', :id => '3'})
  end
  
#math_problem clone
  test "math problem clone new" do
    assert_routing( {:path => "/math_problems/234/clone/new", :method => :get}, 
      {:controller => 'clone', :action => 'new', :math_problem_id => '234'})
  end

#available_tags
  test "availble_tag index" do
    assert_routing( {:path => "/problem_types/algebra-fractions/available_tags", :method => :get}, 
      {:controller => "available_tags", :action => "index", :problem_type_id => "algebra-fractions"})
  end

  test "available_tag search" do
    assert_routing( {:path => "/problem_types/algebra-fractions/available_tags/search", :method => :get}, 
      {:controller => "available_tags", :action => "search", :problem_type_id => "algebra-fractions"})    
  end
  
#searches
# problem type searches
  test "new problem type search" do
    assert_routing( {:path => "problem_types/search", :method => :get}, {:controller => "problem_types/search", :action => 'new'} )
  end
  
  test "problem type search show results" do
    assert_routing( {:path => "problem_types/search/results", :method => :get}, {:controller => "problem_types/search", :action => 'show'} )
  end

#CoreLessonProblemTypes
  test "new core lesson problem type" do
    assert_routing( {:path => "/core_lesson_problem_types", :method => :post },
      {:controller => "core_lesson_problem_types", :action => 'create'})
  end

#Worksheet
  test "create worksheet" do
    assert_routing( {:path => "worksheets", :method => :post }, {:controller => "worksheets", :action => "create"})
  end

  test "edit worksheet" do
    assert_routing( {:path => "worksheets/34/edit", :method => :get },
      {:controller => "worksheets", :action => "edit", :id => '34'})
  end

  test "show worksheet" do
    assert_routing( {:path => "worksheets/34", :method => :get },
      {:controller => "worksheets", :action => "show", :id => '34'})
  end
  
  test "delete worksheet" do
    assert_routing( {:path => "worksheets/234", :method => :delete }, {:controller => "worksheets", :action => "destroy", :id => '234'})
  end

#WorksheetBuilders  
  test "worksheet builder create" do
    assert_routing( {:path => "worksheet_builder", :method => :post}, 
      {:controller => "worksheet_builder", :action => "create"})
  end

  test "problem_type worksheet builder new" do
    assert_routing( {:path => "problem_types/50/worksheet_builder", :method => :get}, 
      {:controller => "problem_type_worksheet_builder", :action => "new", :permalink => '50'})
  end

#Worksheet Problems
  test "delete worksheet problem" do
    assert_routing( {:path => "/worksheet_problems/8", :method => :delete}, {:controller => "worksheet_problems", :action => "destroy", :id => '8'})
  end
  
#WorksheetSolutions
  test "show worksheet_solutions" do
    assert_routing( {:path => "/worksheet_solutions/89", :method => :get }, 
      {:controller => "worksheet_solutions", :action => 'show', :id => '89'})
  end
end