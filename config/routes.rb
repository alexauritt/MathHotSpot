Mathhotspot::Application.routes.draw do
  
  devise_for :users

  root :to => "ProblemTypes::Search#new"
  
  resources :categories
  
  resource :instructions

  match 'admin' => 'admin#index', :as => :admin

  namespace :admin do
    resources :subjects, :except => [:show]
    resources :lessons, :except => [:show]
  end  
    
  resources :tags, :except => [:index, :new, :create, :edit, :update, :show, :delete] do

  end
  
  resources :subjects, :only => [:show, :index]
    
  resources :lessons

  resources :math_problems, :except => [:new, :index] do
    resources :clone, :only => [:new]
  end
  
  resources :worksheets, :only => [:index, :show, :edit, :update, :create] do
    resources :worksheet_problems, :only => [:update]
  end

  resources :worksheet_problems, :only => [:destroy]
  
  resources :worksheet_solutions, :only => [:show]
  
  match "problem_types/search/results" => 'problem_types/search#show', :as => :problem_types_search
  match "problem_types/search" => 'problem_types/search#new', :as => :new_problem_types_search

  get "problem_types/:permalink/worksheet_builder" => 'problem_type_worksheet_builder#new',
    :as => :new_problem_type_worksheet_builder
  post "problem_types/:permalink/worksheet_builder" => 'problem_type_worksheet_builder#create',
      :as => :problem_type_worksheet_builder
  
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
