Mathhotspot::Application.routes.draw do

  devise_for :users

  root :to => "Worksheets::MyWorksheets#index"
  
  resources :categories
  
  resource :instructions

  match 'admin' => 'admin#index', :as => :admin

  namespace :admin do
    resources :subjects, :except => [:show]
    resources :lessons, :except => [:show]
  end  
    
  resources :tags, :except => [:index, :new, :create, :edit, :update, :show, :delete]
  
  resources :subjects, :only => [:show, :index]
    
  resources :lessons

  resources :math_problems, :except => [:new, :index]
  
  get "my_worksheets" => 'worksheets/my_worksheets#index', :as => :my_worksheets
  
  get "math_problems/:math_problem_id/new" => 'clone/math_problem_clone#new', :as => :math_problem_clone
  get "worksheets/:worksheet_id/problem/:problem_number/new" => 'clone/worksheet_problem_clone#new', 
    :as => :worksheet_problem_clone

  resources :worksheets do
    resources :worksheet_problems, :only => [:update, :new]
  end

  resources :worksheet_problems, :only => [:destroy, :create]
  
  post "worksheet_problem_replacer" => 'worksheet_problem_replacer#create', :as => :worksheet_problem_replacer
  post "worksheet_problem_adder" => 'worksheet_problem_adder#create', :as => :worksheet_problem_adder
  
  resources :worksheet_solutions, :only => [:show]
  
  match "problem_types/search/results" => 'problem_types/search#show', :as => :problem_types_search
  match "problem_types/search" => 'problem_types/search#new', :as => :new_problem_types_search

  post "worksheet_builder" => 'worksheet_builder#create', :as => :worksheet_builder
  get "problem_types/:permalink/worksheet_builder" => 'problem_type_worksheet_builder#new',
    :as => :new_problem_type_worksheet_builder
  get "lessons/:id/worksheet_builder" => 'lesson_worksheet_builder#new', :as => :new_lesson_worksheet_builder

  resources :problem_types, :except => [:delete] do
    resources :problem_levels, :except => [:create] do
      resources :math_problems, :only => [:new]
    end
    resources :available_tags, :only => [:index]
  end
    
  resources :problem_levels, :only => [:create]
  
  resources :core_lesson_problem_types, :only => [:create]
    
  match '/dashboard' => 'dashboards#show', :as => :dashboard
  match '/my_lessons' => 'my_lessons#index', :as => :my_lessons
  match '/problem_types/:problem_type_id/available_tags/search' => 'available_tags#search', :as => :available_tag_search
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
