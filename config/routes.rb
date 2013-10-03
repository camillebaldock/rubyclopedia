Rubyclopedia::Application.routes.draw do
  match '/rate' => 'rater#create', :as => 'rate'

  devise_for :users

  root :to => "home#index"

  resources :articles do
    put :updateStatus, on: :member
  end

  post '/notes/:article_id/:user_id', to: 'notes#update'

  match '/about' => 'pages#about'

end