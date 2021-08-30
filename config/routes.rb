Rails.application.routes.draw do
  
  resources :projects do
    resources :bugs
  end

  devise_for :users
  get 'projects/index'
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"


  match '/addmember', to: 'projects#addmember',  :via => [:get, :post]
  match '/addall', to: 'projects#addall',  :via => [:get, :post]
  match '/assign', to: 'bugs#assignuser',  :via => [:post]
  match '/resolve', to: 'bugs#resolveBug',  :via => [:post]
end
