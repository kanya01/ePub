# Rails.application.routes.draw do
#   get "profiles/show"
#   get "profiles/edit"
#   get "profiles/update"
#   root "home#index"
#   devise_for :users
#
#   resource :profile, only: [:show, :edit, :update]
#   resources :publications
#   namespace :admin do
#     resources :users
#   end
# end
Rails.application.routes.draw do
  root "home#index"  # Keep your current root route

  devise_for :users

  # Profile routes
  resource :profile, only: [:show, :edit, :update]

  # Publications routes - making them more RESTful and adding necessary routes
  resources :publications do
    member do
      post 'like'
      post 'bookmark'
      post 'comment'
    end
    collection do
      get 'ai_generated'  # For filtering AI-generated publications
    end
  end

  # Admin namespace
  namespace :admin do
    resources :users
  end
end