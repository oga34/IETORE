Rails.application.routes.draw do
 root to: 'public/homes#top'
 
 namespace :admin do
  resources :users, only: [:index,:show,:edit,:update]
  get 'users/:id/information/edit' => 'users#edit', as: 'information_edit'
  patch  'users/:id/information' => 'users#update', as: 'information_update'
  get 'users/favorites' => 'users#favorites'
  get 'posts/favorited_user/:id' => 'posts#favorited_user', as: 'favorited_user'
  get 'posts/draft' => 'posts#draft', as: 'draft'
  resources :posts, only: [:show,:destroy] do
   resources :post_comments, only: [:destroy]
  end
  resources :genres, only: [:index,:create,:edit,:update]
  root to: 'homes#top'
 end
 
 scope module: :public do
   get 'homes/index' => 'homes#index'
   get 'users/my_page/:id' => 'users#show', as: 'my_page'
   get 'users/information/edit' => 'users#edit', as: 'information_edit'
   patch  'users/information' => 'users#update', as: 'information_update'
   get 'users/unsubcribe' => 'users#unsubcribe'
   patch 'users/withdraw' => 'users#withdraw'
   get 'users/favorites' => 'users#favorites'
   get 'posts/favorited_user/:id' => 'posts#favorited_user', as: 'favorited_user'
   get 'posts/draft' => 'posts#draft', as: 'draft'
   resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
   end
 end
   
# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
 registrations: "public/registrations",
 sessions: 'public/sessions'
 
}

##ゲストログイン用
post 'homes/guest_sign_in', to: 'public/homes#new_guest'

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
 sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
