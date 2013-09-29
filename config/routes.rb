Rubyclopedia::Application.routes.draw do
  devise_for :users

  root :to => "home#index"

  resources :articles do
    put :favourite, on: :member
    put :viewed, on: :member
  end

  match '/about' => 'pages#about'

end