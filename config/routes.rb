OspreyModel::Application.routes.draw do

  post 'upload' => 'files#upload'


  get 'models'  => 'models#all'
  get 'models/:id'  => 'models#show'
  get 'models/:id/bodies'  => 'models#bodies'
  get 'models/:id/location'  => 'models#location'
  get 'models/:id/preview' => 'models#preview'
  get 'models/:id/levels'  => 'models#levels'


  get 'bodies' => 'bodies#all'
  get 'bodies/:id'  => 'bodies#show'
  get 'bodies/:id/data'  => 'bodies#data'


  get 'locations' => 'locations#all'
  get 'locations/:id'  => 'locations#show'
  get 'locations/:id/image'  => 'locations#image'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
