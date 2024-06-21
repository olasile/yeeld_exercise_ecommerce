Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  resources :payment_form, only: [:index]
  resources :products, except: [:edit, :update]
  resources :orders, only: [:index] do
    collection do
      get :new_complete
      get :complete
    end
  end
end
