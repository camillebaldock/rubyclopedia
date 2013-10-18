Rubyclopedia::Application.routes.draw do
  devise_for :users
  root :to => "home#index"
  resources :articles do
    put :updateStatus, on: :member
  end
  resources :submissions

  namespace :admin do
    resources :articles
  end

  get '/users/:username', to: 'users#show'
  post '/notes/:article_id/:user_id', to: 'notes#save'
  post '/ratings/:id', to: 'ratings#update'
  match '/about' => 'pages#about'

end