Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  # prototypesコントローラーで設定した以下のアクションに対するルーティングを記述
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
  # どのツイートに対するコメントなのかをパスから判断できるようにする為、ルーティングのネストを使う
    resources :comments, only: [:create]
  end
  # deviseにはユーザーの詳細ページについての設定がデフォルトでない為、自分でルーティングを設定
  resources :users, only: [:show]
end
