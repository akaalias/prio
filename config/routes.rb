Rails.application.routes.draw do
  root 'tasks#index'
  get '/tasks', to: 'tasks#index'
  get '/comparisons/new', to: 'comparisons#new'
  post '/comparisons', to: 'comparisons#create'
  get '/comparisons/reprioritize', to: 'comparisons#reprioritize'
end
