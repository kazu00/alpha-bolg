Rails.application.routes.draw do
  resources :articles
    # / でpagesコントローラーのhomeアクションに飛ぶ
    root 'pages#home'
    get '/about', to: 'pages#about'
    
    # articles#index, create, newなど7種類のアクションを自動で設定する
    resources :articles
end
