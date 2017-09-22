Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new' #新規登録URLを/signupにするためだけに個別に設定
  resources :users, only: [:index, :show, :new, :create] do
    #memberは/users/:id/followingsといった感じに生成
    #collectionは/users/followingsの様に生成
    member do
      get :followings
      get :followers
    end
  end
  
  
  #resources　の後ろはコントローラー名なので（テーブル名ではない）注意
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
