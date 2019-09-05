Rails.application.routes.draw do
    # / でpagesコントローラーのhomeアクションに飛ぶ
    root 'pages#home'
    get '/about', to: 'pages#about'
    
    # articles#index, create, newなど7種類のアクションを自動で設定する
    resources :articles
    
    get 'signup', to: 'users#new'
    resources :users, expect: [:new]
end
