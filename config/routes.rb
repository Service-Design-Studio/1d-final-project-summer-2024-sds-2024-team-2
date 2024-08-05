# config/routes.rb
Rails.application.routes.draw do
  root 'user_particulars#show' # set root path of web app as /user_particulars/show for now

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  post 'user_particulars/:id/generate_2fa', to: 'user_particulars#generate_2fa', as: 'generate_2fa'
  get 'user_particulars/:id/history', to: 'user_particulars#history', as: 'user_history'
  get 'user_particulars/:id/document', to: 'user_particulars#document', as: 'user_document'
  get 'user_particulars/:id/contact_ngo', to: 'user_particulars#contact_ngo', as: 'contact_ngo'
  post 'user_particulars/:id/:ngoid/message', to: 'user_particulars#message', as: 'user_message'

  resources :user_particulars do
    member do
      get 'saved_post'
      get 'page2'
    end
    resources :documents, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :uploaded_files, only: [:index, :create, :destroy]
  end

  resources :ngo_users do
    member do
      post 'check_user' # Add this line for post action to verify user
      get 'verify', to: 'ngo_users#verify', as: 'verify' # Add this line for the verify action
      post 'verify', to: 'ngo_users#verify'
      post 'confirm_verify', to: 'ngo_users#confirm_verify'
      get 'inbox', to: 'ngo_users#inbox', as: 'inbox'
    end
  end

  resources :bulletins
  resources :saved_posts
end
