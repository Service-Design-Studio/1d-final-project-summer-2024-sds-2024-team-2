Rails.application.routes.draw do
  root 'user_particulars#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

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

  delete 'user_particulars/:user_particular_id/uploaded_files/:id', to: 'uploaded_files#destroy', as: 'destroy_uploaded_file'

  resources :ngo_users do
    member do
      post 'check_user'
      get 'verify', to: 'ngo_users#verify', as: 'verify'
      post 'verify', to: 'ngo_users#verify'
      post 'confirm_verify', to: 'ngo_users#confirm_verify'
      get 'inbox', to: 'ngo_users#inbox', as: 'inbox'
    end
  end

  resources :bulletins
  resources :saved_posts
end
