OpenProject::Application.routes.draw do

  resources :accountcreators do
    collection { post :import }
  end

  get 'accountcreators/:id', to: 'users_controller#show'
  get 'accountcreators/groups/:id', to: 'groups_controller#show'
  #resources :users, controller: 'users_controller'
#  resources :users, only: [:index, :delete, :edit, :show]




end
