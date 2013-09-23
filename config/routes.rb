Rubyclopedia::Application.routes.draw do
  root :to => "home#index"
  resources :articles do
    member do
      post 'watched'
    end
  end
end