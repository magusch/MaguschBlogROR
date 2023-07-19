Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users
  root "articles#index"

  resources :articles do
    resources :comments do
      member do
        put :archive
      end
    end
  end

  get '/profile', to: 'profiles#show', as: :user_profile
end
