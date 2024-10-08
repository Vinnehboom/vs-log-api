Rails.application.routes.draw do
  namespace :admin do
    resources :archetypes, only: %i[index show new create edit update destroy]
    resources :decks, only: %i[index show new create edit update]
    resources :games, only: %i[index show new create edit update]
    resources :lists, only: %i[index show new create edit update]
    resources :matches, only: %i[index show new create edit update]

    root to: "games#index"
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope ":game", as: "game_id" do
    resources :decks do
      resources :lists, controller: "decks/lists"
      resources :matches, controller: "decks/matches"
    end
    resources :archetypes, only: %i[index show]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
