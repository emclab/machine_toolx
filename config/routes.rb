MachineToolx::Engine.routes.draw do

  resources :machine_tools
  
  root :to => 'machine_tools#index'
end
