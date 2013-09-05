Rails.application.routes.draw do

  mount MachineToolx::Engine => "/machine_toolx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  
end
