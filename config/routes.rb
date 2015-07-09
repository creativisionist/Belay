Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users, :controllers => { registrations: 'users/registrations'}
  namespace :users do
    resources :children
  end

  resources :tasks
  resources :rewards
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
