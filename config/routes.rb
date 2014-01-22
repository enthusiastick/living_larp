LivingLarp::Application.routes.draw do

  mount RailsAdmin::Engine => '/frood', :as => 'rails_admin'

  root 'pages#index'

  devise_for :users

  resources :contacts, only: [:new, :create]

  get '/contact_us', to: 'contacts#new'

  resources :games, only: [:create, :index, :new, :show] do
    resources :game_traits, only: [:create, :index, :new, :show, :update]
    resources :game_trait_dependencies, only: [:create, :new, :index, :show]
    resources :players, only: [:create, :index, :new, :show, :update]
  end

  resources :characters, only: [:create, :index, :new, :show, :update] do
    resources :traits, only: [:create, :new, :show]
  end

  get ':controller/:action/:game_id', as: :player_characters

end
