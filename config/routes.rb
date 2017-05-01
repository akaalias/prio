Rails.application.routes.draw do
  root 'pages#home'

  get '/tasks', to: 'tasks#index'
  get '/tasks/new', to: 'tasks#new'
  post '/tasks/create', to: 'tasks#create'

  get '/comparisons/new', to: 'comparisons#new'
  post '/comparisons', to: 'comparisons#create'
  get '/comparisons/reprioritize', to: 'comparisons#reprioritize'
end
