RubyCastsProgressTracker::Application.routes.draw do
  root :to => "episodes#index"
  resources :episodes do
  	member do
  	  post 'watched'
    end
  end
end