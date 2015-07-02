Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'

  resources :tasks, :users, :rewards
  # resources :users do
  #   resources :tasks
  #   resources :rewards
  # end

  # get '/tasks' => 'tasks#index'
  # get '/tasks/new' => 'tasks#new'
  # post '/tasks' => 'tasks#create'
  # get '/tasks/:id' => 'tasks#show'
  # get '/tasks/:id/edit' => 'tasks#edit'
  # patch '/tasks/:id' => 'tasks#update'
  # delete 'tasks/:id' => 'tasks#destroy'
end
