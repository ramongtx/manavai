Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cards, only: [:index] do
    member do
      put 'want'
      put 'have'
    end
    collection do
      post 'album'
    end
  end

  resources :users, only: %i[index show], path: 'u' do
    member do
      get 'wants'
      get 'haves'
    end
  end

  root to: 'cards#index'
end
