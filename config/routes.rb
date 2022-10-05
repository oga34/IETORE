Rails.application.routes.draw do
 root to: 'public/homes#top'
  
 get "search" => "posts#search"
 
 namespace :admin do
  resources :users, only: [:index,:show,:edit,:update]
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
    
 scope module: :public do
   get 'posts/draft' => 'posts/draft'
   resources :posts
 end
   
 scope module: :public do
   resources :posts_comments
 end
   
 scope module: :public do
   resources :favorites, only: [:create,:destroy]
 end

# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
 registrations: "public/registrations",
 sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
 sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
