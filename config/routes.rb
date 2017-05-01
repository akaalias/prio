Rails.application.routes.draw do
  root 'tasks#index'
  get '/tasks', to: 'tasks#index'
  get '/comparisons/new', to: 'comparisons#new'
  post '/comparisons', to: 'comparisons#create'
end
