Mathhotspot::Application.routes.draw do
  resources :categories

  match 'admin' => 'admin#index', :as => :admin

  namespace :admin do
    resources :subjects, :except => [:show]
    resources :lessons, :except => [:show]
  end  
  
  match 'menu' => 'menus#index', :as => :menu
  match '/menu/:tag' => 'menus#tag_menu', :as => :tag_menu
  
  resources :tags, :except => [:index, :new, :create, :edit, :update, :show, :delete] do
    resources :menus, :only => [:show]
  end
  
  resources :subjects, :only => [:show, :index]

  resources :categories
    
  resources :lessons do
    resources :problem_types, :only => [:new]
    resources :instructions, :only => [:new, :create]
  end

  resources :math_problems, :except => [:new, :index]

  resources :worksheets, :only => [:index, :show, :update] do
    resources :worksheet_problems, :only => [:update]
  end
  
  resources :problem_types, :except => [:new, :delete] do
    resources :problem_levels, :only => [:new, :update]
    resources :available_tags, :only => [:index]
  end
  
  match '/problem_types/:problem_type_id/available_tags/search' => 'available_tags#search', :as => :available_tag_search
  
  resources :problem_levels, :only => [:show, :create] do
    resources :math_problems, :only => [:new]
  end

  resources :grouped_problems, :only => [:index]
  
  resources :rogue_problems, :only => [:index, :new]
  
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
