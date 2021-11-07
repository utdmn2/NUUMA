Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords,], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #top
  root to: "homes#top"
  get '/guideline' => 'homes#guideline'

  #namespaceでURL指定のパス、ファイル構成指定のパスに
  namespace :admin do
    resources :users, except: [:new, :create, :edit, :destroy]
    resources :posts, except: [:new, :create, :edit, :destroy]
    resources :categories, except: [:new, :show, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get "unsubscribe"
      patch "withdraw"
    end

    resource :relationships, only: [:create, :destroy] do
    collection do
      get "followings"
      get "followers"
    end
    end
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end
