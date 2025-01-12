Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users, path: 'users', path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    sign_up: 'sign-up',
    registration: 'register',
  }, controllers: {
    sessions: 'users/sessions', as: 'users/sign-in',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
  }

  authenticated :user do
    root to: 'events#index', as: :authenticated_root
    resources :events, only: [:new, :create, :index, :show, :destroy] do
      collection do
        get :view_own, as: 'view-own'
      end
    end
    resources :tickets, only: [:new, :create, :index, :show, :destroy]
  end

  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end
end
