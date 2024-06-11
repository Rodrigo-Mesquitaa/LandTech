Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recruiters do
        resources :jobs, only: [:create, :update, :destroy]
      end
      resources :jobs, only: [:index, :show]
      resources :submissions, only: [:create]
    end
  end
end
