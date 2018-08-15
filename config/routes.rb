Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'merchants/:id/favorite_customer', to: 'merchants/favorite_customer#show'

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end


end
