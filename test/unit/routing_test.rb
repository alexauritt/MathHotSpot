require 'test_helper'

class RoutingTest < ActionController::TestCase

  test "menu index route" do
    assert_routing( { :path => "menu", :method => :get}, {:controller => "menus", :action => "index"})
  end
  
  test "tag menu route" do
    assert_routing( { :path => "menu/a_math_problem_tag", :method => :get}, {:controller => "menus", :action => "tag_menu", :tag => "a_math_problem_tag"})
  end
  
  test "lesson_instruction new" do
    assert_routing( {:path => "lessons/32/instructions/new", :method => :get}, 
      {:controller => "instructions", :action => "new", :lesson_id => '32'})
  end
  
  test "lesson_instruction create" do
    assert_routing( {:path => "lessons/32/instructions", :method => :post}, 
      {:controller => "instructions", :action => "create", :lesson_id => '32'})    
  end

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
  
  test "problem_type_problem_level new" do
    assert_routing( {:path => "/problem_types/123/problem_levels/new", :method => :get}, {:controller => "problem_levels", :action => "new", :problem_type_id => "123"})
  end
  
  test "problem_level_math_problem new" do
    assert_routing( {:path => "/problem_levels/987/math_problems/new", :method => :get}, 
      {:controller => "math_problems", :action => "new", :problem_level_id => "987"})    
  end

  test "problem_level create" do
    assert_routing( {:path => "/problem_levels", :method => :post}, {:controller => "problem_levels", :action => "create"})
  end
  
  test "problem_type edit / update" do
    assert_routing( {:path => "problem_types/234/edit", :method => :get}, {:controller => "problem_types", :action => 'edit', :id => '234'})
    assert_routing( {:path => "problem_types/654", :method => :put}, {:controller => "problem_types", :action => 'update', :id => '654'})
  end

  test "rogue_problems new" do 
    assert_routing( {:path => "/rogue_problems/new", :method => :get}, {:controller => "rogue_problems", :action => "new"})
  end
    
  test "rogue_problems index" do 
    assert_routing( {:path => "/rogue_problems", :method => :get}, {:controller => "rogue_problems", :action => "index"})
  end
  
  # resources :rogue_problems, :only => [:index, :new]
  
  
end