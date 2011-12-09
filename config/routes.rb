TheYorker::Application.routes.draw do

  root :to => 'sections#show', :id => 1

  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'users#login', :as => :login

  resources :sessions, :sections, :privilege_lists

  resources :articles do
    member do
      get 'review'
      get 'comments'
      get 'publish'
    end
  end

  resources :users do
    member do
      get 'sections'
      get 'articles'
      get 'admin'
    end
  end

  match 'users/:id/dashboard' => 'users#dashboard'
  match 'users/:id/suspend' => 'users#suspend'
  match 'users/:id/unsuspend' => 'users#unsuspend'

  # post "articles/:id/comments"

  match 'articles/:id/comments' => 'comments#create'
  match 'comments/:id/hide' => 'comments#hide'
  match 'comments/:id/unhide' => 'comments#unhide'

  post 'editors/create'


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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
