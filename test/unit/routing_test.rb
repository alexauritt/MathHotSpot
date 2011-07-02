require 'test_helper'

class RoutingTest < ActionController::TestCase

# menus
  test "menu index route" do
    assert_routing( { :path => "/", :method => :get}, {:controller => "menus", :action => "index"})
  end
  
  test "tag menu route" do
    assert_routing( { :path => "menu/a_math_problem_tag", :method => :get}, {:controller => "menus", :action => "tag_menu", :tag => "a_math_problem_tag"})
  end

#instructions
  test "lesson_instruction new" do
    assert_routing( {:path => "lessons/32/instructions/new", :method => :get}, 
      {:controller => "instructions", :action => "new", :lesson_id => '32'})
  end
  
  test "lesson_instruction create" do
    assert_routing( {:path => "lessons/32/instructions", :method => :post}, 
      {:controller => "instructions", :action => "create", :lesson_id => '32'})    
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
  
#problem_types
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

  
#rogue_problems
  test "rogue_problems new" do 
    assert_routing( {:path => "/rogue_problems/new", :method => :get}, {:controller => "rogue_problems", :action => "new"})
  end
    
  test "rogue_problems index" do 
    assert_routing( {:path => "/rogue_problems", :method => :get}, {:controller => "rogue_problems", :action => "index"})
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
  
end