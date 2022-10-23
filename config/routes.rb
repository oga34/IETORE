Rails.application.routes.draw do
 root to: 'public/homes#top'
  
 get "search" => "posts#search"
 
 namespace :admin do
  resources :users, only: [:index,:show,:edit,:update]
 end
 
 namespace :admin do
  resources :posts, only: [:index,:show,:edit,:update,:destroy]
 end
  
 namespace :admin do
  resources :genres, only: [:index,:create,:edit,:update]
 end
  
 namespace :admin do
  root to: 'homes#top'
 end
  
 get 'users/my_page' => 'public/users#show', as: 'my_page'
 get 'users/information/edit' => 'public/users#edit', as: 'information_edit'
 patch  'users/information' => 'public/users#update', as: 'information_update'
 get 'users/unsubcribe' => 'public/users#unsubcribe'
 patch 'users/withdraw' => 'public/users#withdraw'
 get 'users/favorites' => 'public/users#favorites'
    
 scope module: :public do
   get 'posts/draft' => 'posts#draft', as: 'draft'
   get 'homes/index' => 'homes#index'
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
