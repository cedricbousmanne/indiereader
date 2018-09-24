Rails.application.routes.draw do
  
  resource :session, only: [:new, :create, :destroy] do
    member do
      get 'callback'
    end
  end

  resources :channels
  
  root to: 'visitors#index'
end
