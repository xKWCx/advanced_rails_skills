Rails.application.routes.draw do
  resources :coverages, only: [:show]
  resources :quotes, only: [:index, :show]

  root to: "quotes#index"
end
