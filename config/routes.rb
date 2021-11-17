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
  get '/privacy' => 'homes#privacy'
  get '/post_rule' => 'homes#post_rule'

  # get '/search' => 'user/searches#search'

  #admin側（namespaceでURL指定のパス、ファイル構成指定のパスに）
  namespace :admin do
    resources :users, except: [:new, :create, :edit, :destroy]
    resources :posts, except: [:new, :create, :edit, :destroy]
    resources :categories, except: [:new, :show, :destroy]
  end

  scope module: :user do
    resources :posts do
      resource :favorites, only: [:create, :destroy] #いいね機能
      resources :post_comments, only: [:create, :destroy] #コメント機能
    end
  end

  scope module: :user do
    resources :users, only: [:show, :edit, :update] do
      member do
        get "unsubscribe" #退会画面表示
        patch "withdraw" #会員ステータスを退会へ変更
      end

    resource :relationships, only: [:create, :destroy] do
      collection do
        get "followings" #フォローしている人一覧
        get "followers" #フォローされている人一覧
      end
    end
    end
    
    resource :searches, only: [:search] do
      get "search"
    end

  end
end
