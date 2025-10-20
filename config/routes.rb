Rails.application.routes.draw do
  # トップ関連
  get  "top/main"
  post "top/login"
  get  "top/logout"

  # プロフィール関連（ここがポイント！）
  resources :users do
    resource :profile  # ← 単数形（1対1関係のとき）
  end

  # つぶやき機能
  resources :tweets
  resources :likes, only: [:create] do
    delete '', action: :destroy, on: :collection
  end



  # ルート設定
  root "tweets#index"
end
