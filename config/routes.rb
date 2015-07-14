Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, :controllers => { registrations: 'users/registrations'}
  namespace :users do
    resources :children
  end

  resources :tasks
  patch '/update_status/:id' => 'tasks#update_status'
  resources :rewards
  patch '/update_reward_status/:id' => 'rewards#update_reward_status'
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
