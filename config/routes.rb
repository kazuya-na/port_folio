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
    resources :end_users, only: [:show, :edit, :update]
    get 'end_users/withdraw_confirm' => 'end_users#withdraw_confirm', as: 'withdraw_confirm'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
    resources :posts, only: [:new, :index, :destroy] do
      resources:post_comments, only: [:create, :destroy]
      resource:favorites, only: [:create, :destroy]
    end
    resources :room_users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
