Rails.application.routes.draw do

  namespace :user do
    get 'posts/index'
    get 'posts/show'
    get 'posts/new'
    get 'posts/edit'
  end
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

  root to: 'homes#top'
  get '/guideline' => 'homes#guideline'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
