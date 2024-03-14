Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions',
    passwords: 'users/passwords'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'publics/sessions#guest_sign_in'
  end
  
  
  namespace :admins do
    get '/' => 'homes#top', as: 'top'
    resources :comments, except: %w[new]
    resources :posts, except: %w[new]
    resources :end_users, except: %w[new create]
    resources :tags, except: %w[show]
  end
  
  scope module: :publics do
    root to: 'posts#index'
    resources :posts do
      resources :comments, except: %w[new index]
    end
    
    get 'search' => 'searches#search'
    resource :likes, only: %w[create destroy]
    resources :tags, except: %w[index show destroy]
    
    resources :users, only: %w[show edit update] do
      member do
        get :confirm
        patch :withdraw
        get :likes
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
