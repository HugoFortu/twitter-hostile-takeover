Rails.application.routes.draw do
  devise_for :users,
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            } 
  get '/member-data', to: 'members#show'
  get '/leaderboard', to: 'members#index'
  resources :tweets, only: [:index, :create, :destroy, :update] do
    collection do
      get 'my_tweets', to: 'tweets#user_tweets'
    end
  end
  resources :likes, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
