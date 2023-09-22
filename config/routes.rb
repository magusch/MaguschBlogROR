Rails.application.routes.draw do
  get 'comment_votes/create'
  get 'comment_votes/destroy'
  get 'profiles/show'
  devise_for :users
  root "articles#index"

  resources :articles do
    resources :comments do
      member do
        put :archive
        put :publish
      end
    end

    collection do
      post 'markdown_to_html'
      get 'markdown_to_html'
    end

  end

  resources :pages do
    member do
      put :change_navbar_display
    end
  end

  post 'articles/:article_id/comments/:comment_id/vote', to: 'comment_votes#create', as: :upvote_article_comment
  delete 'articles/:article_id/comments/:comment_id/vote', to: 'comment_votes#destroy', as: :unvote_article_comment

  get '/profile/:id', to: 'profiles#show', as: :profile
  get '/profile/me', to: 'profiles#show', as: :user_profile
  get '/profiles', to: 'profiles#index', as: :profiles
end
