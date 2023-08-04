Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :end_users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'end_users/sessions#guest_sign_in'
  end


  namespace :admin do
    get 'homes/top' => 'homes#top'
    # 退会確認画面のroutesを追加
    get 'withdraw_confirm' => 'end_users#withdraw_confirm', as: 'withdraw_confirm'
    patch 'withdraw' => 'end_users#withdraw', as: 'withdraw'
    resources :end_users, only: [:index, :show, :edit, :update]
  end


  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about'
    get "search" => "searches#search"
    get 'end_users/withdraw_confirm' => 'end_users#withdraw_confirm', as: 'withdraw_confirm'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    resources :diaries, only: [:create, :index, :show, :edit, :update, :destroy]

    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resources:post_comments, only: [:create, :destroy]
      resource:favorites, only: [:create, :destroy]
    end

    resources :end_users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
    end

    resources :chat_rooms, only: [:new, :create, :index, :show, :destroy] do
      resources :chat_messages, only: [:create, :destroy]
      resources :room_users, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end