Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  
  devise_for :users, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions',
    passwords: 'users/passwords'
  }
  resources :posts, except: %w[index]
  resources :tags, except: %w[index show destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
