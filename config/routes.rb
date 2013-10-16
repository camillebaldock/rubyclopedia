Rubyclopedia::Application.routes.draw do
  match '/rate' => 'rater#create', :as => 'rate'

  devise_for :users

  root :to => "home#index"

  resources :articles do
    put :updateStatus, on: :member
  end

  namespace :admin do
    resources :articles
  end

  get '/users/:username', to: 'users#show'
  post '/notes/:article_id/:user_id', to: 'notes#update'

  match '/about' => 'pages#about'

end