Rails.application.routes.draw do

  root 'questions#new'
  
  resources :questions, path: :q do
    member do
      post 'answer', to: 'answer#create'
    end
  end

  get :responses, to: 'responses#index'

  get 'user', to: 'user#show'
  post 'user/show-secret', to: 'user#show_secret'
  post 'user/merge', to: 'user#merge'
  post 'user/reset-secret', to: 'user#reset_secret'

  get 'login', to: 'session#new', as: :login
  post 'login', to: 'session#create', as: :session
  delete 'logout', to: 'session#destroy', as: :logout
end
