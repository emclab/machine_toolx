MachineToolx::Engine.routes.draw do
  
  get "machine_tools/index"

  get "machine_tools/new"

  get "machine_tools/create"

  get "machine_tools/edit"

  get "machine_tools/update"

  get "machine_tools/show"

  resources :machine_tools
  
  root :to => 'machine_tools#index'
end
