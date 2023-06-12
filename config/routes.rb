Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :end_users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :end_users, only: [:index, :show, :edit, :update]
  end


  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about'

    get 'end_users/withdraw_confirm' => 'end_users#withdraw_confirm', as: 'withdraw_confirm'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    resources :end_users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource:favorites, only: [:create, :destroy]
      resources:post_comments, only: [:create, :destroy]
    end

    resources :diaries, only: [:create, :index, :show, :edit, :update, :destroy]
    resources :room_users, only: [:create, :destroy]
    resources :chat_messages, only: [:create, :show, :destroy]
    resources :chat_rooms, only: [:new, :create, :index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end