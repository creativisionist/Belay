Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations'}

  devise_scope :user do
    authenticated :user do
      root 'homes#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

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

  namespace :api do
    namespace :v1 do
      get '/children' => 'children#index'
      patch '/children/:id' => 'children#update'
      post '/children' => 'children#create'

      get '/parents' => 'parents#index'
      patch '/interest_rate' => 'parents#update_interest_rate'
    end
  end
end
