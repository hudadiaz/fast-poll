Rails.application.routes.draw do

  root 'questions#new'
  
  resources :questions, path: :q do
    member do
      post 'answer', to: 'answer#create'
    end
  end

  get :responses, to: 'responses#index'

  get 'user', to: 'user#show'
  post 'user/merge', to: 'user#merge'
  post 'user/reset-secret', to: 'user#reset_secret'

  scope :session do
    get '/new', to: 'session#new', as: :login
    post '/', to: 'session#create', as: :session
    delete '/', to: 'session#destroy', as: :logout
  end
end
