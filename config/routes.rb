RubyCastsProgressTracker::Application.routes.draw do
  root :to => "home#index"
  resources :episodes do
  	member do
  	  post 'watched'
    end
  end
end