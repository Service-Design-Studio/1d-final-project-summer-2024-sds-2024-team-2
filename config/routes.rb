# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user_histories/create'
  # Set root path of web app
  root 'user_particulars#show'

  # Devise routes for user authentication
  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

  # Custom routes for user particulars
  get 'user_particulars/confirm'
  post 'user_particulars/:id/generate_2fa', to: 'user_particulars#generate_2fa', as: 'generate_2fa'
  get 'user_particulars/:id/history', to: 'user_particulars#history', as: 'user_history'
  get 'user_particulars/:id/contact_ngo', to: 'user_particulars#contact_ngo', as: 'contact_ngo'
  post 'user_particulars/:id/:ngoid/message', to: 'user_particulars#message', as: 'user_message'

  # Resources for user particulars, with nested documents resources
  resources :user_particulars do
    member do
      get 'saved_post'
      get 'page2'
    end
    resources :documents, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  # Resources for NGO users with custom member routes for verification and inbox
  resources :ngo_users do
    member do
      post 'check_user' # Post action to verify user
      get 'verify', to: 'ngo_users#verify', as: 'verify' # Verify action
      post 'verify', to: 'ngo_users#verify'
      post 'confirm_verify', to: 'ngo_users#confirm_verify'
      get 'inbox', to: 'ngo_users#inbox', as: 'inbox'
    end
  end

  # Resources for bulletins and saved posts
  resources :bulletins
  resources :saved_posts
end
