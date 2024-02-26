Rails.application.routes.draw do
  devise_for :users,
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            } 
  get '/member-data', to: 'members#show'
  resources :tweets, only: [:index, :create, :destroy, :update] do
    collection do
      get 'my_tweets', to: 'tweets#user_tweets'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
