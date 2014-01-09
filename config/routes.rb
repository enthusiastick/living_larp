LivingLarp::Application.routes.draw do

  root 'games#index'

  devise_for :users

  resources :contacts, only: [:new, :create]

  get '/contact_us', to: 'contacts#new'

  resources :games, only: [:create, :index, :new, :show] do
    resources :game_traits, only: [:create, :index, :new, :show]
  end

  resources :characters, only: [:create, :new, :show] do
    resources :traits, only: [:create, :new]
  end

end
