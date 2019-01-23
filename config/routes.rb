Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      resources :bios
      resources :announcements
      resources :users

      post '/login', to: 'auth#login'
      get '/current_user', to: 'auth#currentUser'
      post '/signup', to: 'auth#signup'

    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
