Rails.application.routes.draw do
  resources :quotes do
    member do
      get :update_products
    end
  end
  resources :coverages, only: [:show]

  root to: "quotes#index"
end
