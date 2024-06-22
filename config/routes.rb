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
    resources :users, except: %w[new create]
    resources :tags, except: %w[show]
    resources :favorites, only: %w[create destroy]
  end

  scope module: :publics do
    root to: 'posts#index'
    
    resources :posts do
      resource :comments, except: %w[new index]
      resource :favorites, only: %w[create destroy]
    end

    get 'search' => 'searches#search'
    
    resources :tags, only: %w[index show destroy]
    resources :favorites, only: %w[create destroy]
    
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
