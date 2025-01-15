Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  root "home#index"
  devise_for :users

  resource :profile, only: [:show, :edit, :update]
  resources :publications
  namespace :admin do
    resources :users
  end
end
