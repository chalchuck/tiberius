Rails.application.routes.draw do
  
  resources :tasks do
  	resources :sub_tasks
  end

  resources :users do
  	resources :projects
  end

  resources :projects do
    resources :tasks
  end

  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
