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

  get '/child_dashboard' => 'dashboards#child_dashboard'
  post '/child_dashboard' => 'dashboards#savings'
  patch '/child_dashboard/:id' => 'dashboards#update_status'

  get '/parent_dashboard' => 'dashboards#parent_dashboard'
  post '/parent_dashboard' => 'dashboards#update_interest'
end
