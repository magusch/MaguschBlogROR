Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles do
    resources :comments do
      member do
        put :archive
      end
    end
  end
end
