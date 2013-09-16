RubyCastsProgressTracker::Application.routes.draw do
  resources :episodes do
  	member do
  	  post 'watched'
    end
  end
end